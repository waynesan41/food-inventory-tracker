import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:food_inventory_tracker/provider/food_list.dart';
import 'package:food_inventory_tracker/widgets/foodItemDisplay/food_card.dart';

class DeletedFoodCardList extends StatelessWidget {
  const DeletedFoodCardList({super.key});

  @override
  Widget build(BuildContext context) {
    final foodItemData = Provider.of<FoodItemList>(context, listen: false);
    final foodItems = foodItemData.deletedFoodItemList;
    return RefreshIndicator(
      onRefresh: Provider.of<FoodItemList>(context).fetchDeletedFoodItemList,
      child: foodItems.length == 0 || foodItems.isEmpty
          ? const Center(
              child: Text("No Deleted Items.."),
            )
          : GridView.builder(
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
