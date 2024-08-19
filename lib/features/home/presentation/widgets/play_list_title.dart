import 'package:chillzone/features/home/models/audio/audio_track.dart';
import 'package:flutter/material.dart';

class PlaylistTitle extends StatelessWidget {
  final AudioGenre genre;
  const PlaylistTitle({
    super.key,
    required this.genre,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        '${genre.name} Playlist',
        style: textStyle,
      ),
    );
  }
}
