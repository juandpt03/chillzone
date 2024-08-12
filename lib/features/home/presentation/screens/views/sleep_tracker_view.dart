import 'package:flutter/material.dart';

class SleepTrackerView extends StatelessWidget {
  static const routeName = '/sleep-tracker';
  const SleepTrackerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('SleepTrackerView'),
      ),
    );
  }
}
