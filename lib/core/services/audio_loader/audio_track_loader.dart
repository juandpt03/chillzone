import 'dart:convert';
import 'package:chillzone/features/home/models/audio/audio_track.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';

class AudioTrackLoader {
  final List<AudioTrack> audioTrackList;

  AudioTrackLoader({required this.audioTrackList});

  factory AudioTrackLoader.fromJson(Map<String, dynamic> json) {
    const String musicKey = 'music';
    if (json.containsKey(musicKey)) {
      var musicJsonList = json[musicKey] as List;
      List<AudioTrack> audioTrackList =
          musicJsonList.map((i) => AudioTrack.fromJson(i)).toList();
      return AudioTrackLoader(audioTrackList: audioTrackList);
    } else {
      throw const FormatException("Key '$musicKey' not found in JSON.");
    }
  }

  static Future<AudioTrackLoader> loadFromAssets(String path) async {
    try {
      String jsonString = await rootBundle.loadString(path);
      Map<String, dynamic> jsonData = json.decode(jsonString);
      return AudioTrackLoader.fromJson(jsonData);
    } catch (e) {
      throw Exception("Failed to load audio tracks from asset: $e");
    }
  }

  List<AudioTrack> getTracksByGenre(AudioGenre genre) {
    var random = Random();
    var shuffledTracks = audioTrackList.toList()..shuffle(random);
    return shuffledTracks.where((track) => track.genre == genre).toList();
  }
}
