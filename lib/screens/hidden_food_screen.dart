//==
import "package:flutter/material.dart";
import "package:food_inventory_tracker/widgets/mainScreenAppBar/filter_sort_hidden.dart";
import "package:provider/provider.dart";
import "package:food_inventory_tracker/screens/add_food_screen.dart";
import "package:food_inventory_tracker/widgets/foodItemDisplay/hidden_food_card_list.dart";
import "package:food_inventory_tracker/widgets/mainScreenAppBar/filter_sort.dart";
import "package:food_inventory_tracker/widgets/mainScreenAppBar/search_hidden.dart";
import "package:food_inventory_tracker/widgets/mainScreenAppBar/drawer_menu.dart";
import "package:food_inventory_tracker/provider/food_list.dart";

class HiddenFoodScreen extends StatelessWidget {
  const HiddenFoodScreen({super.key});

  static const routName = "/hidden-food-item";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const HiddenSearchInputText(),
        actions: [
          FilterSortHidden(),
        ],
      ),
      drawer: DrawerMenu(),
      body: FutureBuilder(
        future: Provider.of<FoodItemList>(context, listen: false)
            .fetchAndSetHiddenFoodItemList(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<FoodItemList>(
                    builder: (context, value, _) => HiddenFoodCardList(),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .pushNamed(AddFoodScreen.routeName, arguments: true);
        },
      ),
    );
  }
}
