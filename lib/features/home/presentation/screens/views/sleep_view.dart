import 'package:flutter/material.dart';
import 'package:chillzone/features/home/models/audio_track.dart';
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
          Center(child: Phrase(genre: AudioGenre.sleep)),
          Spacer(),
          PlaylistTitle(genre: AudioGenre.sleep),
          SizedBox(height: 8),
          Expanded(
            flex: 5,
            child: AudioTracks(),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

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

class AudioTracks extends StatelessWidget {
  const AudioTracks({super.key});

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 1.2,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: 80,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: AudioTrackCard(
              audioTrack: AudioTrack(
                title: 'Title $index',
                composer: 'Composer $index',
                genre: AudioGenre.sleep,
                filePath: 'assets/audio/1.mp3',
              ),
            ),
          );
        },
      ),
    );
  }
}

class AudioTrackCard extends StatefulWidget {
  final AudioTrack audioTrack;
  const AudioTrackCard({super.key, required this.audioTrack});

  @override
  AudioTrackCardState createState() => AudioTrackCardState();
}

class AudioTrackCardState extends State<AudioTrackCard> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _isFocused
              ? colors.primary.withOpacity(0.8)
              : colors.secondary.withOpacity(0.5),
          border: Border.all(
            color: _isFocused ? Colors.white : Colors.transparent,
            width: 3.0,
          ),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: _isFocused
              ? [
                  BoxShadow(
                    color: colors.shadow.withOpacity(0.8),
                    blurRadius: 15.0,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.audioTrack.title,
                style: TextStyle(
                  color: _isFocused ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                widget.audioTrack.composer,
                style: TextStyle(
                  color: _isFocused ? Colors.white70 : Colors.black54,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
