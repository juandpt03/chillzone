import 'package:chillzone/features/home/presentation/providers/providers.dart';
import 'package:chillzone/features/home/presentation/widgets/widgets.dart';
import 'package:chillzone/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioPlayerScreen extends StatelessWidget {
  static const String routeName = '/audio_player_screen';

  const AudioPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _Background(),
          _LeadingButton(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AudioMetadata(),
                SizedBox(height: 16),
                Controls(),
                ProgressBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LeadingButton extends StatelessWidget {
  const _LeadingButton();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Positioned(
      top: 32,
      left: 16,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          size: size.height * 0.03,
        ),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    final pixabayImageState = context.watch<PixabayImagesNotifier>().state;
    final colors = Theme.of(context).colorScheme;
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        pixabayImageState.map(
          loading: (_) => const CustomLoading(),
          success: (state) => Image.network(
            state.imageUrl,
            fit: BoxFit.cover,
          ),
          error: (state) => CustomErrorWidget(
            error: state.error,
            onRetry: () =>
                context.read<PixabayImagesNotifier>().generateRandomImages(),
          ),
        ),
        Container(
          color: colors.scrim.withOpacity(0.7),
        ),
      ],
    );
  }
}
