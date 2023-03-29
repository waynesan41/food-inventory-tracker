//==

import "package:flutter/material.dart";
import "package:food_inventory_tracker/model/food_item.dart";
import "package:food_inventory_tracker/provider/food_list.dart";
import "package:provider/provider.dart";

class HideItemDialog extends StatelessWidget {
  const HideItemDialog(this._foodDetail);

  final FoodItem _foodDetail;

  @override
  Widget build(BuildContext context) {
    void _hideItem() {
      _foodDetail.hidden = true;
      Provider.of<FoodItemList>(context, listen: false)
          .updateDeleteFoodItem(_foodDetail);
    }

    return AlertDialog(
      title: const Text("Hide this Item!"),
      content: const Text("Hidden item can be found in hidden tab."),
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
          child: const Text("Hide Item"),
          onPressed: () {
            // _hideItem();
            // Navigator.of(context).pop();
            // Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
