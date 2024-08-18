import 'package:chillzone/features/home/models/audio_track.dart';
import 'package:chillzone/features/home/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class WorkView extends StatelessWidget {
  static const routeName = '/work';
  const WorkView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Phrase(genre: AudioGenre.work),
          ],
        ),
      ),
    );
  }
}
