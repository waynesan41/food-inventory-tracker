//==

import "package:flutter/material.dart";
import "package:food_inventory_tracker/model/food_item.dart";
import "package:food_inventory_tracker/provider/food_list.dart";
import "package:provider/provider.dart";

class HideItemDialog extends StatelessWidget {
  const HideItemDialog(this._foodDetail, {super.key});

  final FoodItem _foodDetail;

  @override
  Widget build(BuildContext context) {
    void _hideItem() {
      _foodDetail.hidden = !_foodDetail.hidden;
      Provider.of<FoodItemList>(context, listen: false)
          .hideItemUpdate(_foodDetail);
    }

    return AlertDialog(
      title: _foodDetail.hidden
          ? const Text("Reveal this Item")
          : const Text("Hide this Item!"),
      content: _foodDetail.hidden
          ? const Text("Move Item back to main inventory.")
          : const Text("Hidden item can be found in hidden tab."),
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
              Colors.blue,
            ),
          ),
          child: _foodDetail.hidden
              ? const Text("Reveal Item", style: TextStyle(color: Colors.white))
              : const Text("Hide Item", style: TextStyle(color: Colors.white)),
          onPressed: () {
            _hideItem();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
