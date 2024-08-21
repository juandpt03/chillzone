import 'package:chillzone/features/home/presentation/providers/providers.dart';
import 'package:chillzone/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioMetadata extends StatelessWidget {
  const AudioMetadata({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AudioProvider>().state;
    final Size size = MediaQuery.of(context).size;

    return state.map(
      loading: (_) => const CustomLoading(),
      success: (state) {
        final currentTrack = state.currentTrack;
        return Column(
          children: [
            Text(
              currentTrack.title,
              style: TextStyle(
                fontSize: size.height * 0.03,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              currentTrack.composer,
              style: TextStyle(
                fontSize: size.height * 0.02,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
      error: (state) => CustomErrorWidget(
          error: state.error,
          onRetry: () => context.read<AudioProvider>().loadAudioTracks),
    );
  }
}
