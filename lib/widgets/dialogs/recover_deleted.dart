//==

import "package:flutter/material.dart";
import "package:food_inventory_tracker/model/food_item.dart";
import "package:food_inventory_tracker/provider/food_list.dart";
import "package:provider/provider.dart";

class RecoverDialog extends StatelessWidget {
  final FoodItem _foodDetail;
  const RecoverDialog(this._foodDetail);

  @override
  Widget build(BuildContext context) {
    void _recoverDelete() {
      _foodDetail.deleted = null;
      Provider.of<FoodItemList>(context, listen: false)
          .updateDeleteFoodItem(_foodDetail);
    }

    return AlertDialog(
      title: const Text("Recover This Item?"),
      content: const Text("Move item back to Inventory."),
      actions: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.green[600],
            ),
          ),
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.blue[600],
            ),
          ),
          child: const Text("Recover"),
          onPressed: () {
            _recoverDelete();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
