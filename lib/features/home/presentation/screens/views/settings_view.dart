import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  static const routeName = '/settings';
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('SettingsView'),
      ),
    );
  }
}
