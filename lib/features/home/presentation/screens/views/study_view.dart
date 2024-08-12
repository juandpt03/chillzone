import 'package:flutter/material.dart';

class StudyView extends StatelessWidget {
  static const routeName = '/study';
  const StudyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('StudyView'),
      ),
    );
  }
}
