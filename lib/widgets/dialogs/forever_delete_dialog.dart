//==

import "package:flutter/material.dart";
import "package:food_inventory_tracker/model/food_item.dart";
import "package:food_inventory_tracker/provider/food_list.dart";
import "package:provider/provider.dart";

class ForeverDeleteDialog extends StatelessWidget {
  final FoodItem _foodDetail;
  const ForeverDeleteDialog(this._foodDetail);

  @override
  Widget build(BuildContext context) {
    void _deleteForever() {
      Provider.of<FoodItemList>(context, listen: false)
          .deleteFoodItemForever(_foodDetail);
    }

    return AlertDialog(
      title: const Text("Delete Data From Phone!"),
      content: const Text("Deleted Data Won't be able to recover?"),
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
              Colors.red[600],
            ),
          ),
          child: const Text("DELETE"),
          onPressed: () {
            _deleteForever();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
