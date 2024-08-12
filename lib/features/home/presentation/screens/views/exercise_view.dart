import 'package:flutter/material.dart';

class ExerciseView extends StatelessWidget {
  static const routeName = '/exercise';
  const ExerciseView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('ExerciseView'),
      ),
    );
  }
}
