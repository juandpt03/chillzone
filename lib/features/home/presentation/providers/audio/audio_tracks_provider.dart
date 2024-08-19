import 'package:chillzone/core/services/audio_loader/audio_track_loader.dart';
import 'package:chillzone/features/home/models/audio/audio_track.dart';
import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier {
  final AudioGenre genre;
  final List<AudioTrack> _audioTracks = [];

  List<AudioTrack> get audioTracks => _audioTracks;

  set audioTracks(List<AudioTrack> audioTracks) {
    _audioTracks.addAll(audioTracks);
    notifyListeners();
  }

  AudioProvider({
    this.genre = AudioGenre.sleep,
  }) {
    init(genre);
  }

  Future<void> init(AudioGenre genre) async {
    AudioTrackLoader audioTrackLoader =
        await AudioTrackLoader.loadFromAssets('assets/json/music.json');

    audioTracks = audioTrackLoader.getTracksByGenre(genre);
  }
}
