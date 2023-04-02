//===

import 'package:flutter/material.dart';

import 'package:food_inventory_tracker/database/db_helper.dart';

class StatisticsList with ChangeNotifier {
  List<int> _statsData = [];

  List<int> get stats {
    return _statsData;
  }

  Future<void> fetchAndSetStats() async {
    _statsData = await DBHelper.getStats();
  }
}
