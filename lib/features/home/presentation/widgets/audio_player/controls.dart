import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chillzone/features/home/presentation/providers/providers.dart';
import 'package:chillzone/features/shared/shared.dart';

class Controls extends StatelessWidget {
  const Controls({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final state = context.watch<AudioProvider>().state;
    final audioNotifier = context.read<AudioProvider>();
    final audioPlayer = context.watch<AudioPlayerNotifier>();
    final pixabayImagesNotifier = context.read<PixabayImagesNotifier>();

    return state.map(
      loading: (_) => const CustomLoading(),
      success: (state) {
        final currentTrack = state.currentTrack;
        final tracks = state.tracks;
        final currentIndex = tracks.indexOf(currentTrack);

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: currentIndex > 0
                  ? () {
                      audioNotifier.playPreviousTrack();
                      pixabayImagesNotifier.imageUrl(currentIndex - 1);
                    }
                  : null,
              icon: Icon(Icons.skip_previous_rounded, size: size.height * 0.05),
              tooltip: 'Previous',
            ),
            if (audioPlayer.audioPlayer.state == PlayerState.playing)
              IconButton(
                onPressed: () => audioPlayer.pause(),
                icon: Icon(
                  Icons.pause_rounded,
                  size: size.height * 0.05,
                ),
                tooltip: 'Pause',
              )
            else
              IconButton(
                onPressed: () => audioPlayer.play(currentTrack.filePath),
                icon: Icon(
                  Icons.play_arrow_rounded,
                  size: size.height * 0.05,
                ),
                tooltip: 'Play',
              ),
            IconButton(
              onPressed: currentIndex < tracks.length - 1
                  ? () {
                      audioNotifier.playNextTrack();
                      pixabayImagesNotifier.imageUrl(currentIndex + 1);
                    }
                  : null,
              icon: Icon(
                Icons.skip_next_rounded,
                size: size.height * 0.05,
              ),
              tooltip: 'Next',
            ),
          ],
        );
      },
      error: (state) => CustomErrorWidget(
        error: state.error,
        onRetry: () => Navigator.of(context).pop(),
      ),
    );
  }
}
