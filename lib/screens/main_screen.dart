//
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "package:food_inventory_tracker/provider/user_option_data.dart";
import "package:food_inventory_tracker/widgets/appBar.dart";
import 'package:food_inventory_tracker/widgets/mainScreenAppBar/drawer_menu.dart';
import 'package:food_inventory_tracker/widgets/mainScreenAppBar/filter_sort.dart';
import 'package:food_inventory_tracker/widgets/mainScreenAppBar/search_input.dart';
import 'package:food_inventory_tracker/widgets/foodItemDisplay/food_card_list.dart';

class MainScreen extends StatelessWidget {
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
      body: FoodCardList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
