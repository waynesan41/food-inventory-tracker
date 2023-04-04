//==
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "package:food_inventory_tracker/model/food_item.dart";
import "package:food_inventory_tracker/provider/food_list.dart";

class DeleteDialog extends StatelessWidget {
  final FoodItem _foodDetail;
  const DeleteDialog(this._foodDetail, {super.key});

  @override
  Widget build(BuildContext context) {
    void _deleteItem() {
      _foodDetail.deleted = DateTime.now();
      Provider.of<FoodItemList>(context, listen: false)
          .updateDeleteFoodItem(_foodDetail);
    }

    return AlertDialog(
      title: const Text("Delete Item!"),
      content: const Text("Delete This Item?"),
      actions: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.green[600],
            ),
          ),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.red[600],
            ),
          ),
          child: const Text("DELETE", style: TextStyle(color: Colors.white)),
          onPressed: () {
            _deleteItem();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
