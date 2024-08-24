import 'package:chillzone/features/home/presentation/providers/widgets/navigation_provider.dart';
import 'package:chillzone/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomNavigation extends StatelessWidget {
  const CustomNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Consumer<NavigationProvider>(
        builder: (context, navigation, child) {
          return CustomNavigationRail(
            labelType: LabelType.selected,
            destinations: const [
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
                label: 'Read',
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
                icon: Icons.track_changes,
                label: 'Sleep Tracker',
              ),
            ],
            onDestinationSelected: (index) {
              navigation.selectedIndex = index;
            },
            selectedIndex: navigation.selectedIndex,
          );
        },
      ),
    );
  }
}
