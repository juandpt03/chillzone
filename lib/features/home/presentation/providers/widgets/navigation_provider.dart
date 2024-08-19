import 'package:flutter/foundation.dart';

class NavigationProvider with ChangeNotifier {
  int _selectedIndex = 0;
  bool _showNavigationRail = true;

  int get selectedIndex => _selectedIndex;
  bool get showNavigationRail => _showNavigationRail;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  set showNavigationRail(bool show) {
    _showNavigationRail = show;
    notifyListeners();
  }
}
