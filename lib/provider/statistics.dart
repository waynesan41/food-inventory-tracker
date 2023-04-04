//===

import 'package:flutter/material.dart';

import 'package:food_inventory_tracker/database/db_helper.dart';

class StatisticsList with ChangeNotifier {
  List<int> _statsData = [];
  int? _maxID;
  List<int> get stats {
    return _statsData;
  }

  int get maxID {
    return _maxID!;
  }

  Future<void> fetchAndSetStats() async {
    _statsData = await DBHelper.getStats();
  }

  Future<void> fetchMaxID() async {
    _maxID = await DBHelper.getMaxID();
  }
}
