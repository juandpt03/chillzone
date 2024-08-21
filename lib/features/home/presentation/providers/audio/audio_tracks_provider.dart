import 'package:chillzone/core/core.dart';
import 'package:chillzone/core/services/audio_loader/audio_track_loader.dart';
import 'package:chillzone/features/home/models/audio/audio_track.dart';
import 'package:chillzone/features/home/presentation/providers/audio/audio_state.dart';
import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier {
  AudioGenre genre;

  AudioState _state = const AudioState.loading();

  AudioState get state => _state;
  set state(AudioState state) {
    _state = state;
    notifyListeners();
  }

  AudioProvider({
    this.genre = AudioGenre.sleep,
  }) {
    loadAudioTracks();
  }

  Future<void> loadAudioTracks() async {
    try {
      state = const AudioState.loading();

      final audioTrackLoader =
          await AudioTrackLoader.loadFromAssets('assets/json/music.json');

      final tracks = audioTrackLoader.getTracksByGenre(genre);

      state = AudioState.success(tracks: tracks, currentTrack: tracks.first);
    } catch (e) {
      state = const AudioState.error(error: HttpRequestFailure.local);
    }
  }

  void playTrack(AudioTrack track) {
    state = state.success.copyWith(currentTrack: track);
    notifyListeners();
  }

  void playNextTrack() {
    final successState = state.success;
    final currentIndex = successState.tracks.indexOf(successState.currentTrack);
    if (currentIndex < successState.tracks.length - 1) {
      final nextTrack = successState.tracks[currentIndex + 1];
      playTrack(nextTrack);
    }
  }

  void playPreviousTrack() {
    final successState = state.success;
    final currentIndex = successState.tracks.indexOf(successState.currentTrack);
    if (currentIndex > 0) {
      final previousTrack = successState.tracks[currentIndex - 1];
      playTrack(previousTrack);
    }
  }

  void updateGenre(AudioGenre genre) {
    this.genre = genre;
    loadAudioTracks();
  }
}
