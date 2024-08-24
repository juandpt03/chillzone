import 'package:chillzone/features/home/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:chillzone/core/services/image_manager/image_manager.dart';
import 'package:chillzone/features/home/presentation/screens/screens.dart';
import 'package:chillzone/features/home/presentation/widgets/home/custom_navigation.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const SleepView(),
      const WorkView(),
      const ReadView(),
      const ExerciseView(),
      const MeditateView(),
      const SleepTrackerView(),
    ];

    final ImageManager imageManager = ImageManager();
    final navigation = context.watch<NavigationProvider>();

    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            navigation.showNavigationRail = false;
          } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            navigation.showNavigationRail = true;
          }
          if (event.logicalKey == LogicalKeyboardKey.arrowUp &&
              navigation.showNavigationRail) {
            final int selectedIndex = navigation.selectedIndex;
            if (selectedIndex > 0) {
              navigation.selectedIndex = selectedIndex - 1;
            }
          } else if (event.logicalKey == LogicalKeyboardKey.arrowDown &&
              navigation.showNavigationRail) {
            final int selectedIndex = navigation.selectedIndex;
            final int destinationsLength = pages.length;
            if (selectedIndex < destinationsLength - 1) {
              navigation.selectedIndex = selectedIndex + 1;
            }
          }
        }
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            imageManager.getSvgImage(imageManager.nightBackground),
            Container(color: Colors.black.withOpacity(0.7)),
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  width: navigation.showNavigationRail ? 100 : 0,
                  child: navigation.showNavigationRail
                      ? const CustomNavigation()
                      : const SizedBox.shrink(),
                ),
                Expanded(
                  child: pages[navigation.selectedIndex],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
