import 'package:audioplayers/audioplayers.dart';
import 'package:chillzone/features/home/presentation/providers/providers.dart';

import 'package:flutter/material.dart';

class AudioPlayerNotifier extends ChangeNotifier {
  final AudioPlayer audioPlayer;
  final AudioProvider audioProvider;
  final PixabayImagesNotifier pixabayImagesNotifier;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  PlayerState _playerState = PlayerState.stopped;

  AudioPlayerNotifier({
    required this.audioPlayer,
    required this.audioProvider,
    required this.pixabayImagesNotifier,
  }) {
    _setupListeners();
  }

  Duration get duration => _duration;
  Duration get position => _position;
  PlayerState get playerState => _playerState;

  void seek(Duration newPosition) {
    audioPlayer.seek(newPosition);
  }

  void play(String url) async {
    await audioPlayer.play(UrlSource(url));
  }

  void pause() async {
    await audioPlayer.pause();
  }

  void replay() async {
    await audioPlayer.seek(Duration.zero);
  }

  void _setupListeners() {
    _listenToDurationChanges();
    _listenToPositionChanges();
    _listenToPlayerStateChanges();
    _listenToAudioProvider();
    _listenToCompletion();
  }

  void _listenToDurationChanges() {
    audioPlayer.onDurationChanged.listen((duration) {
      _duration = duration;
      notifyListeners();
    });
  }

  void _listenToPositionChanges() {
    audioPlayer.onPositionChanged.listen((position) {
      _position = position;
      notifyListeners();
    });
  }

  void _listenToPlayerStateChanges() {
    audioPlayer.onPlayerStateChanged.listen((state) {
      _playerState = state;
      notifyListeners();
    });
  }

  void _listenToAudioProvider() {
    audioProvider.addListener(() {
      final currentTrack = audioProvider.state.map(
        success: (state) => state.currentTrack,
        error: (state) => null,
        loading: (state) => null,
      );

      final currentIndex = audioProvider.state.map(
        success: (state) => state.tracks.indexOf(state.currentTrack),
        error: (state) => null,
        loading: (state) => null,
      );

      if (currentTrack != null && currentIndex != null) {
        play(currentTrack.filePath);

        pixabayImagesNotifier.imageUrl(currentIndex);
      }
    });
  }

  void _listenToCompletion() {
    audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        audioProvider.playNextTrack();
      }
    });
  }

  void reset() {
    _duration = Duration.zero;
    _position = Duration.zero;
    _playerState = PlayerState.stopped;
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
