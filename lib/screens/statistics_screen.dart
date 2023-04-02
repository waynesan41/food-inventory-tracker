//==
import "package:flutter/material.dart";
import "package:food_inventory_tracker/provider/food_list.dart";
import "package:food_inventory_tracker/provider/statistics.dart";
import "package:food_inventory_tracker/widgets/mainScreenAppBar/drawer_menu.dart";
import "package:food_inventory_tracker/widgets/statistics/statistics_view.dart";
import "package:provider/provider.dart";

class StatisticsScreen extends StatelessWidget {
  static const routName = "/statistics-item";
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Statistics"),
      ),
      drawer: const DrawerMenu(),
      body: FutureBuilder(
        future: Provider.of<StatisticsList>(context, listen: false)
            .fetchAndSetStats(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<FoodItemList>(
                    builder: (context, value, _) => StatisticsView(),
                  ),
      ),
    );
  }
}
