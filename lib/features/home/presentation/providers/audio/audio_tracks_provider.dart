import 'package:chillzone/core/core.dart';
import 'package:chillzone/core/services/audio_loader/audio_track_loader.dart';
import 'package:chillzone/features/home/models/audio/audio_track.dart';
import 'package:chillzone/features/home/presentation/providers/audio/audio_state.dart';
import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier {
  AudioGenre genre;

  AudioState _state = const AudioState.loading();

  AudioState get state => _state;

  AudioProvider({
    this.genre = AudioGenre.sleep,
  }) {
    loadAudioTracks();
  }

  Future<void> loadAudioTracks() async {
    try {
      _state = const AudioState.loading();
      notifyListeners();

      final audioTrackLoader =
          await AudioTrackLoader.loadFromAssets('assets/json/music.json');

      final tracks = audioTrackLoader.getTracksByGenre(genre);

      _state = AudioState.success(tracks: tracks);
      notifyListeners();
    } catch (e) {
      _state = const AudioState.error(error: HttpRequestFailure.local);
      notifyListeners();
    }
  }

  void playTrack(AudioTrack track) {
    _state = state.map(
      loading: (state) => state,
      success: (state) => state.copyWith(currentTrack: track),
      error: (state) => state,
    );
    notifyListeners();
  }

  void updateGenre(AudioGenre genre) {
    this.genre = genre;
    loadAudioTracks();
  }
}
