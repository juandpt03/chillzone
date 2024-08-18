import 'package:chillzone/features/home/models/audio_track.dart';
import 'package:chillzone/features/shared/shared.dart';
import 'package:flutter/material.dart';

class Phrase extends StatelessWidget {
  final AudioGenre genre;
  const Phrase({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displayMedium?.copyWith(
          fontWeight: FontWeight.bold,
        );

    final phraseTextStyle = Theme.of(context).textTheme.titleLarge?.copyWith();
    return Column(
      children: [
        GenreIcon(genre: genre),
        const SizedBox(height: 16),
        Text(
          genre.name,
          style: textStyle,
        ),
        const SizedBox(height: 16),
        Text(
          'Thousands of  free sleep sounds, guided meditations, and bedtime stories',
          style: phraseTextStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
