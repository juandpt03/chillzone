import 'package:chillzone/features/home/models/audio_track.dart';
import 'package:flutter/material.dart';

class GenreIcon extends StatelessWidget {
  final AudioGenre genre;
  const GenreIcon({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Icon(_getGenreIcon(genre), size: 50);
  }

  IconData _getGenreIcon(AudioGenre genre) {
    switch (genre) {
      case AudioGenre.sleep:
        return Icons.nightlight;
      case AudioGenre.work:
        return Icons.work;
      case AudioGenre.read:
        return Icons.book;
      case AudioGenre.exercise:
        return Icons.sports_gymnastics;
      case AudioGenre.meditate:
        return Icons.self_improvement;
      default:
        return Icons.music_note;
    }
  }
}
