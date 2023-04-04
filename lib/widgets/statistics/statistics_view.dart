import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:food_inventory_tracker/provider/statistics.dart';

class StatisticsView extends StatelessWidget {
  StatisticsView({super.key});
  late List<int> statsData = [];
  int? _maxID;
  @override
  Widget build(BuildContext context) {
    statsData = Provider.of<StatisticsList>(context).stats;
    _maxID = Provider.of<StatisticsList>(context).maxID;

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.9,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      padding: const EdgeInsets.all(10.0),
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            "Inventory: ${statsData[0]}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            "Hidden: ${statsData[1]}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            "Deleted: ${statsData[2]}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            "Image: ${statsData[3]}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        /* Container(
          alignment: Alignment.center,
          child: Text(
            "Max ID: ${_maxID}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ), */
      ],
    );
  }
}
