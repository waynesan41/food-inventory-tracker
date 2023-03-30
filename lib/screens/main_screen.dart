//
import "dart:async";

import "package:flutter/material.dart";
import "package:food_inventory_tracker/database/db_helper.dart";
import "package:food_inventory_tracker/provider/food_list.dart";
import "package:food_inventory_tracker/screens/add_food_screen.dart";
import "package:provider/provider.dart";
import "package:sqflite/sqflite.dart" as sql;

import "package:food_inventory_tracker/provider/user_option_data.dart";
import 'package:food_inventory_tracker/widgets/mainScreenAppBar/drawer_menu.dart';
import 'package:food_inventory_tracker/widgets/mainScreenAppBar/filter_sort.dart';
import 'package:food_inventory_tracker/widgets/mainScreenAppBar/search_input.dart';
import 'package:food_inventory_tracker/widgets/foodItemDisplay/food_card_list.dart';
import "package:sqflite/sqlite_api.dart";

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
        future: Provider.of<FoodItemList>(context, listen: false)
            .fetchAndSetFoodItemList(),
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
