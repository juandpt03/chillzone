import 'package:chillzone/features/home/models/audio/audio_track.dart';
import 'package:chillzone/features/home/presentation/providers/audio/audio_tracks_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioTracks extends StatefulWidget {
  final AudioGenre genre;
  const AudioTracks({
    super.key,
    required this.genre,
  });

  @override
  AudioTracksState createState() => AudioTracksState();
}

class AudioTracksState extends State<AudioTracks> {
  final FocusNode _firstTileFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _firstTileFocusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AudioProvider(
        genre: widget.genre,
      ),
      builder: (context, _) {
        final audioProvider = context.watch<AudioProvider>();

        return FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.2,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: audioProvider.audioTracks.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: AudioTrackCard(
                  focusNode: index == 0 ? _firstTileFocusNode : FocusNode(),
                  audioTrack: audioProvider.audioTracks[index],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class AudioTrackCard extends StatefulWidget {
  final AudioTrack audioTrack;
  final FocusNode focusNode;

  const AudioTrackCard({
    super.key,
    required this.audioTrack,
    required this.focusNode,
  });

  @override
  AudioTrackCardState createState() => AudioTrackCardState();
}

class AudioTrackCardState extends State<AudioTrackCard> {
  late ValueNotifier<bool> _isFocusedNotifier;

  @override
  void initState() {
    super.initState();
    _isFocusedNotifier = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    _isFocusedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Focus(
      focusNode: widget.focusNode,
      onFocusChange: (hasFocus) {
        _isFocusedNotifier.value = hasFocus;
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: _isFocusedNotifier,
        builder: (context, isFocused, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: isFocused
                  ? colors.primary.withOpacity(0.8)
                  : colors.secondary.withOpacity(0.5),
              border: Border.all(
                color: isFocused ? Colors.white : Colors.transparent,
                width: 3.0,
              ),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: isFocused
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
                      color: isFocused ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.audioTrack.composer,
                    style: TextStyle(
                      color: isFocused ? Colors.white70 : Colors.black54,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
