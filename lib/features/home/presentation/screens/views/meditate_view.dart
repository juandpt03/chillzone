import 'package:flutter/material.dart';

class MeditateView extends StatelessWidget {
  static const routeName = '/meditate';
  const MeditateView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Meditate'),
      ),
    );
  }
}
