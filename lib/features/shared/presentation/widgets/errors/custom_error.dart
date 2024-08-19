import 'package:chillzone/core/utils/failures.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final HttpRequestFailure error;
  final VoidCallback onRetry;

  const CustomErrorWidget({
    super.key,
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.titleLarge?.copyWith();
    final titleTextStyle = Theme.of(context).textTheme.displayMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: colors.error,
        );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            'Oops!',
            style: titleTextStyle,
          ),
          const SizedBox(height: 16),
          Text(
            error.when(
              network: () => 'Check your internet connection',
              notFound: () => 'Resource not found',
              server: () => 'Server issues, please try again later',
              unauthorized: () => 'Access denied, please log in',
              badRequest: () => 'Request error, please check your data',
              local: () => 'App error, please restart and try again',
            ),
            style: textStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: onRetry,
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}
