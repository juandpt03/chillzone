import 'package:chillzone/features/home/models/audio/audio_track.dart';
import 'package:chillzone/features/home/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class WorkView extends StatelessWidget {
  static const routeName = '/work';
  const WorkView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(flex: 2),
            Expanded(
              flex: 3,
              child: Center(child: Phrase(genre: AudioGenre.work)),
            ),
            Spacer(flex: 1),
            PlaylistTitle(genre: AudioGenre.work),
            SizedBox(height: 8),
            Expanded(
              flex: 5,
              child: AudioTracks(genre: AudioGenre.work),
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
