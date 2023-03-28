//==
import "package:flutter/material.dart";
import "package:food_inventory_tracker/provider/food_list.dart";
import "package:food_inventory_tracker/widgets/mainScreenAppBar/drawer_menu.dart";
import "package:provider/provider.dart";

class StatisticsScreen extends StatelessWidget {
  static const routName = "/statistics-item";
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statistics Screen"),
        actions: [],
      ),
      drawer: DrawerMenu(),
      body: FutureBuilder(
        future: Provider.of<FoodItemList>(context, listen: false)
            .fetchAndSetFoodItemList(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<FoodItemList>(
                    builder: (context, value, _) => Text("Statistics"),
                  ),
      ),
    );
  }
}
