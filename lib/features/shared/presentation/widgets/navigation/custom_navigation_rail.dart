import 'package:flutter/material.dart';

class CustomNavigationRail extends StatelessWidget {
  final List<CustomNavigationRailDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final LabelType labelType;
  final EdgeInsets padding;

  const CustomNavigationRail({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.labelType = LabelType.selected,
    this.padding = const EdgeInsets.only(top: 20),
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final double iconSize = size.height / (destinations.length * 3);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: destinations.asMap().entries.map((entry) {
        int index = entry.key;
        CustomNavigationRailDestination destination = entry.value;
        bool isSelected = index == selectedIndex;

        return GestureDetector(
          onTap: () => onDestinationSelected(index),
          child: Padding(
            padding: padding,
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  width: isSelected ? iconSize + 20 : iconSize + 10,
                  height: isSelected ? iconSize + 20 : iconSize + 10,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colors.primary.withOpacity(0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    destination.icon,
                    size: iconSize,
                    color: isSelected
                        ? colors.primary
                        : colors.onSurface.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 8),
                if (labelType == LabelType.all || isSelected)
                  Text(
                    destination.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isSelected
                          ? colors.primary
                          : colors.onSurface.withOpacity(0.8),
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class CustomNavigationRailDestination {
  final IconData icon;
  final String label;

  const CustomNavigationRailDestination({
    required this.icon,
    required this.label,
  });
}

enum LabelType {
  all,
  selected,
}
