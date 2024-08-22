import 'package:chillzone/features/home/models/audio/audio_track.dart';

class QueryGenerator {
  QueryGenerator._internal();

  static final QueryGenerator _instance = QueryGenerator._internal();

  factory QueryGenerator() => _instance;

  String generateQuery(AudioGenre genre) {
    switch (genre) {
      case AudioGenre.work:
        return 'inspiring landscapes, mountain view, sunrise, nature, open sky, calm scenery';
      case AudioGenre.read:
        return 'cozy nature spot, forest, peaceful landscape, lake view, quiet garden, autumn scenery';
      case AudioGenre.exercise:
        return 'dynamic nature, beach sunrise, mountain trail, open fields, invigorating landscape, running path';
      case AudioGenre.sleep:
        return 'night sky, serene landscape, calm sea, moonlight, quiet forest, starry night, sunset';
      case AudioGenre.meditate:
        return 'tranquil nature, zen garden, misty mountains, calm water, peaceful forest, sunrise meditation spot';
      default:
        return 'relaxing landscape, calm nature, peaceful scenery, soothing view, green fields';
    }
  }
}
