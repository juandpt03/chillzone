import 'package:flutter/material.dart';

class WorkView extends StatelessWidget {
  static const routeName = '/work';
  const WorkView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('WorkView'),
      ),
    );
  }
}
