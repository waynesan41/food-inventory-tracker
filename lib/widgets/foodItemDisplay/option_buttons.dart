import 'package:flutter/material.dart';
import 'package:food_inventory_tracker/model/food_item.dart';
import 'package:food_inventory_tracker/screens/edit_food_screen.dart';

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
            icon: Icon(Icons.save_alt),
            onPressed: () {},
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
            onPressed: () {},
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
            icon: const Icon(Icons.security),
            onPressed: () {},
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
