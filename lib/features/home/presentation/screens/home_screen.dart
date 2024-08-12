import 'package:chillzone/core/services/image_manager/image_manager.dart';
import 'package:chillzone/features/home/presentation/widgets/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const HomeScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final ImageManager imageManager = ImageManager();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          imageManager.getSvgImage(imageManager.nightBackground),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          Row(
            children: [
              CustomNavigation(navigationShell: navigationShell),
              Expanded(child: navigationShell)
            ],
          ),
        ],
      ),
    );
  }
}
