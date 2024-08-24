import 'package:chillzone/features/home/models/audio/audio_track.dart';
import 'package:chillzone/features/home/presentation/providers/providers.dart';
import 'package:chillzone/features/home/presentation/screens/audio_player_screen.dart';
import 'package:chillzone/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioTracks extends StatefulWidget {
  final AudioGenre genre;
  const AudioTracks({
    super.key,
    required this.genre,
  });

  @override
  State<AudioTracks> createState() => _AudioTracksState();
}

class _AudioTracksState extends State<AudioTracks> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AudioProvider>().updateGenre(widget.genre);
      context.read<PixabayImagesNotifier>().updateGenre(widget.genre);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final audioProvider = context.watch<AudioProvider>();
    final imageProvider = context.watch<PixabayImagesNotifier>().state;

    return audioProvider.state.map(
      loading: (_) => const CustomLoading(),
      success: (state) => FocusScope(
        autofocus: true,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 1.2,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: state.tracks.length,
          itemBuilder: (context, index) {
            return imageProvider.map(
              loading: (_) => const CustomLoading(),
              success: (pixabayState) => InkWell(
                borderRadius: BorderRadius.circular(12),
                hoverColor: colors.primary.withOpacity(0.5),
                focusColor: colors.primary,
                onTap: () {
                  context.read<AudioProvider>().playTrack(state.tracks[index]);
                  Navigator.pushNamed(context, AudioPlayerScreen.routeName);
                  context.read<PixabayImagesNotifier>().imageUrl(index);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AudioTrackCard(
                    audioTrack: state.tracks[index],
                    imageUrl: pixabayState.images[index],
                  ),
                ),
              ),
              error: (state) => CustomErrorWidget(
                error: state.error,
                onRetry: () async => context
                    .read<PixabayImagesNotifier>()
                    .generateRandomImages(),
              ),
            );
          },
        ),
      ),
      error: (state) => CustomErrorWidget(
        error: state.error,
        onRetry: () async => await audioProvider.loadAudioTracks(),
      ),
    );
  }
}

class AudioTrackCard extends StatelessWidget {
  final AudioTrack audioTrack;
  final String imageUrl;

  const AudioTrackCard(
      {super.key, required this.audioTrack, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final Size size = MediaQuery.of(context).size;

    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                audioTrack.title,
                style: TextStyle(
                  color: colors.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: size.height * 0.025,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                audioTrack.composer,
                style: TextStyle(
                  color: colors.onSurface.withOpacity(0.7),
                  fontSize: size.height * 0.02,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
