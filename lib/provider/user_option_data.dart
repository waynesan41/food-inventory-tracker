//====
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptionData with ChangeNotifier {
  //Default Data
  OptionData(this.pref);
  final pref;

  //Change Filter Sorting
  bool? _themeState;

  void switchTheme() async {
    _themeState = !_themeState!;
    pref.setBool("userTheme", _themeState!);
    print("SSSWITTTCH");
    print(_themeState);
    notifyListeners();
  }

  void setTheme(bool theme) {
    _themeState = theme;
  }

  bool get themeState {
    fetchAndSetUserTheme();
    return _themeState!;
  }

  Future<void> fetchAndSetUserTheme() async {
    if (pref.getBool("userTheme") == null) {
      pref.setBool("userTheme", true);
      _themeState = true;
      print("SeTTTTTTT");
      notifyListeners();
    } else {
      _themeState = pref.getBool("userTheme");
      print("FEEEtch");
    }
    print(_themeState);
  }
}
