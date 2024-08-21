import 'package:flutter/material.dart';
import 'package:chillzone/features/home/models/audio/audio_track.dart';
import 'package:chillzone/features/home/presentation/widgets/widgets.dart';

class SleepView extends StatelessWidget {
  static const String route = '/sleep';
  const SleepView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(flex: 2),
          Expanded(
            flex: 3,
            child: Center(child: Phrase(genre: AudioGenre.sleep)),
          ),
          Spacer(flex: 5),
          PlaylistTitle(genre: AudioGenre.sleep),
          SizedBox(height: 8),
          Expanded(
            flex: 5,
            child: AudioTracks(genre: AudioGenre.sleep),
          ),
          Center(child: Controls()),
          ProgressBar()
        ],
      ),
    );
  }
}
