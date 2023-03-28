import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:food_inventory_tracker/provider/food_list.dart';
import 'package:food_inventory_tracker/widgets/foodItemDisplay/food_card.dart';

class FoodCardList extends StatelessWidget {
  const FoodCardList({super.key});

  @override
  Widget build(BuildContext context) {
    final foodItemData = Provider.of<FoodItemList>(context, listen: false);
    final foodItems = foodItemData.foodItemList;

    return RefreshIndicator(
      onRefresh: Provider.of<FoodItemList>(context).fetchAndSetFoodItemList,
      child: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: foodItems.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          // create: (c) => products[i],
          value: foodItems[i],
          child: FoodCard(),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
