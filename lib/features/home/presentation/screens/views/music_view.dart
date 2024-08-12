import 'package:flutter/material.dart';

class MusicView extends StatelessWidget {
  static const routeName = '/music';
  const MusicView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('MusicView'),
      ),
    );
  }
}
