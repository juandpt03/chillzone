import 'package:chillzone/features/home/models/audio_track.dart';
import 'package:chillzone/features/home/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ReadView extends StatelessWidget {
  static const routeName = '/read';
  const ReadView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Phrase(genre: AudioGenre.read),
          ],
        ),
      ),
    );
  }
}
