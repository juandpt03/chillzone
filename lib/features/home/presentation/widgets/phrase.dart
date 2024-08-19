import 'package:chillzone/core/core.dart';
import 'package:chillzone/features/home/models/audio/audio_track.dart';
import 'package:chillzone/features/home/presentation/providers/providers.dart';
import 'package:chillzone/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Phrase extends StatelessWidget {
  final AudioGenre genre;
  const Phrase({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displayMedium?.copyWith(
          fontWeight: FontWeight.bold,
        );

    final phraseTextStyle = Theme.of(context).textTheme.titleLarge?.copyWith();

    final messageProvider = MessageProvider(
      messageRepository: ServiceLocator().get(),
      genre: genre,
    );

    return ChangeNotifierProvider<MessageProvider>(
      create: (_) => messageProvider,
      builder: (context, child) {
        final provider = context.watch<MessageProvider>();

        return provider.state.map(
          loading: (_) => const CustomLoading(),
          success: (state) {
            return Column(
              children: [
                GenreIcon(genre: genre),
                const SizedBox(height: 16),
                Text(
                  genre.name,
                  style: textStyle,
                ),
                const SizedBox(height: 16),
                Text(
                  state.message.message,
                  style: phraseTextStyle,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
          error: (state) => CustomErrorWidget(
            error: state.error,
            onRetry: provider.getMessages,
          ),
        );
      },
    );
  }
}
