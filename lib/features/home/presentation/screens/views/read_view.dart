import 'package:chillzone/features/home/models/audio/audio_track.dart';
import 'package:chillzone/features/home/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ReadView extends StatelessWidget {
  static const routeName = '/read';
  const ReadView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(flex: 2),
          Expanded(
            flex: 3,
            child: Center(child: Phrase(genre: AudioGenre.read)),
          ),
          Spacer(flex: 1),
          PlaylistTitle(genre: AudioGenre.read),
          SizedBox(height: 8),
          Expanded(
            flex: 5,
            child: AudioTracks(genre: AudioGenre.read),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
