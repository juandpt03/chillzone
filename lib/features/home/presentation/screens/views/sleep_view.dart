import 'package:flutter/material.dart';

class SleepView extends StatelessWidget {
  static const String route = '/sleep';
  const SleepView({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .displaySmall
        ?.copyWith(fontWeight: FontWeight.bold);
    return Scaffold(
      body: Center(
        child: Text(
          'Thousands of candles can be lighted from a single candle, and the life of the candle will not be shortened. Happiness never decreases by being shared.',
          style: textStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
