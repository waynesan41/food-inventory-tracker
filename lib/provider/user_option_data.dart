//====
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptionData with ChangeNotifier {
  OptionData(this.pref) {
    this.fetchAndSetUserTheme();
  }
  final SharedPreferences pref;

  //Change Filter Sorting
  bool? _themeState;

  void switchTheme() async {
    _themeState = !_themeState!;
    pref.setBool("userTheme", _themeState!);
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

      notifyListeners();
    } else {
      _themeState = pref.getBool("userTheme");
    }
  }
}
