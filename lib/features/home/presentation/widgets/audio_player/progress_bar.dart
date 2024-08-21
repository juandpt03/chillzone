import 'package:chillzone/core/core.dart';
import 'package:chillzone/features/home/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final audioProvider = context.watch<AudioPlayerNotifier>();
    final colors = Theme.of(context).colorScheme;
    final duration = audioProvider.duration;
    final position = audioProvider.position;
    final formatter = StringFormatter();

    if (duration == Duration.zero) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Text('00:00', style: TextStyle(fontSize: size.height * 0.015)),
            Expanded(
              child: Slider(
                activeColor: colors.primary,
                inactiveColor: colors.onSurface.withOpacity(0.4),
                value: 0,
                onChanged: null,
              ),
            ),
            Text('00:00', style: TextStyle(fontSize: size.height * 0.015)),
          ],
        ),
      );
    }

    final progress = position.inMilliseconds / duration.inMilliseconds;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Text(
            formatter.formatDuration(position),
            style: TextStyle(fontSize: size.height * 0.015),
          ),
          Expanded(
            child: Slider(
              activeColor: colors.primary,
              inactiveColor: colors.onSurface.withOpacity(0.4),
              value: progress,
              onChanged: (value) {
                final newPosition = Duration(
                  milliseconds: (value * duration.inMilliseconds).round(),
                );
                audioProvider.seek(newPosition);
              },
            ),
          ),
          Text(
            formatter.formatDuration(duration),
            style: TextStyle(fontSize: size.height * 0.015),
          ),
        ],
      ),
    );
  }
}
