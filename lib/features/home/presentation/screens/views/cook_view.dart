import 'package:flutter/material.dart';

class CookView extends StatelessWidget {
  static const String routeName = '/cook';
  const CookView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('CookView'),
      ),
    );
  }
}
