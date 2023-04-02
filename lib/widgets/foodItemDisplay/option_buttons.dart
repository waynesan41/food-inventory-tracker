import 'package:flutter/material.dart';
import 'package:food_inventory_tracker/widgets/dialogs/save_image_dialog.dart';

import 'package:food_inventory_tracker/model/food_item.dart';
import 'package:food_inventory_tracker/screens/edit_food_screen.dart';
import 'package:food_inventory_tracker/widgets/dialogs/delete_dialog.dart';
import 'package:food_inventory_tracker/widgets/dialogs/hide_item_dialog.dart';

class OptionButtons extends StatelessWidget {
  const OptionButtons(this._foodDetail);
  final FoodItem _foodDetail;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(15),
            shape: BoxShape.rectangle,
          ),
          child: IconButton(
            color: Colors.green,
            icon: _foodDetail.imgUrl == null
                ? const Icon(Icons.save_alt)
                : const Icon(Icons.save_alt),
            onPressed: () async {
              //Save Image to Inventory
              return showDialog(
                context: context,
                builder: (context) => SaveImageDialog(_foodDetail),
              );
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.error, width: 2),
            borderRadius: BorderRadius.circular(15),
            shape: BoxShape.rectangle,
          ),
          child: IconButton(
            color: Theme.of(context).colorScheme.error,
            icon: const Icon(Icons.delete),
            onPressed: () async {
              //Delete Item
              return showDialog(
                context: context,
                builder: (context) => DeleteDialog(_foodDetail),
              );
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(255, 144, 202, 249), width: 2),
            borderRadius: BorderRadius.circular(15),
            shape: BoxShape.rectangle,
          ),
          child: IconButton(
            color: const Color.fromARGB(255, 144, 202, 249),
            icon: _foodDetail.hidden
                ? const Icon(Icons.unarchive_outlined)
                : const Icon(Icons.security),
            onPressed: () async {
              //Hide Item
              return showDialog(
                context: context,
                builder: (context) => HideItemDialog(_foodDetail),
              );
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.secondary, width: 2),
            borderRadius: BorderRadius.circular(15),
            shape: BoxShape.rectangle,
          ),
          child: IconButton(
            color: Theme.of(context).colorScheme.secondary,
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditFoodScreen.routName, arguments: _foodDetail);
            },
          ),
        ),
      ],
    );
  }
}
