import 'package:chillzone/core/core.dart';
import 'package:chillzone/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:chillzone/features/home/presentation/screens/screens.dart';

class AppRouter {
  final _transitionManager = ServiceLocator().get<TransitionManager>();

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return _transitionManager.fadeTransitionPage(
          page: const HomeScreen(),
        );
      case AudioPlayerScreen.routeName:
        return _transitionManager.scaleFadeTransitionPage(
          page: const AudioPlayerScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text('Ruta no encontrada: ${settings.name}')),
          ),
        );
    }
  }
}
