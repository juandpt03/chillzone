import 'package:chillzone/features/home/models/audio_track.dart';
import 'package:chillzone/features/home/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ExerciseView extends StatelessWidget {
  static const routeName = '/exercise';
  const ExerciseView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Phrase(genre: AudioGenre.exercise),
          ],
        ),
      ),
    );
  }
}
