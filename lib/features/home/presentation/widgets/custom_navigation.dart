import 'package:chillzone/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const CustomNavigation({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = navigationShell.currentIndex;

    return SizedBox(
      width: 100,
      child: CustomNavigationRail(
        labelType: LabelType.selected,
        destinations: const [
          CustomNavigationRailDestination(
            icon: Icons.track_changes,
            label: 'Sleep Tracker',
          ),
          CustomNavigationRailDestination(
            icon: Icons.nightlight,
            label: 'Sleep',
          ),
          CustomNavigationRailDestination(
            icon: Icons.work,
            label: 'Work',
          ),
          CustomNavigationRailDestination(
            icon: Icons.book,
            label: 'Study',
          ),
          CustomNavigationRailDestination(
            icon: Icons.cookie,
            label: 'Cook',
          ),
          CustomNavigationRailDestination(
            icon: Icons.sports_gymnastics,
            label: 'Exercise',
          ),
          CustomNavigationRailDestination(
            icon: Icons.self_improvement,
            label: 'Meditate',
          ),
          CustomNavigationRailDestination(
            icon: Icons.settings,
            label: 'Settings',
          ),
        ],
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == selectedIndex,
          );
        },
      ),
    );
  }
}
