import 'package:chillzone/features/home/models/audio_track.dart';
import 'package:chillzone/features/home/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MeditateView extends StatelessWidget {
  static const routeName = '/meditate';
  const MeditateView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Phrase(genre: AudioGenre.meditate),
          ],
        ),
      ),
    );
  }
}
