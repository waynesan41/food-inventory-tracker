import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptionData with ChangeNotifier {
  //Default Data

  //Change Filter Sorting
  bool _themeState = true;

  void switchTheme() {
    _themeState = !_themeState;
    notifyListeners();
  }

  bool get themeState {
    return _themeState;
  }
}
