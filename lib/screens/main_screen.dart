//
import "dart:async";

import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "package:food_inventory_tracker/provider/food_list.dart";
import "package:food_inventory_tracker/screens/add_food_screen.dart";
import 'package:food_inventory_tracker/widgets/mainScreenAppBar/drawer_menu.dart';
import 'package:food_inventory_tracker/widgets/mainScreenAppBar/filter_sort.dart';
import 'package:food_inventory_tracker/widgets/mainScreenAppBar/search_input.dart';
import 'package:food_inventory_tracker/widgets/foodItemDisplay/food_card_list.dart';

class MainScreen extends StatelessWidget {
  static final routeName = "/food-screen";
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchInputText(),
        actions: [
          FilterSortMain(),
        ],
      ),
      drawer: DrawerMenu(),
      body: FutureBuilder(
        future: Future.wait([
          Provider.of<FoodItemList>(context, listen: false)
              .fetchAndSetFoodItemList(),
        ]),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<FoodItemList>(
                    builder: (context, value, _) => FoodCardList(),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .pushNamed(AddFoodScreen.routeName, arguments: false);
        },
      ),
    );
  }
}
