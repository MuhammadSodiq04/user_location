import 'package:flutter/material.dart';
import 'package:user_location/ui/map/map_screen.dart';

class TabBoxProvider with ChangeNotifier {
  int activeIndex = 0;

  void changeIndex(int index) {
    activeIndex = index;
    notifyListeners();
  }
}
