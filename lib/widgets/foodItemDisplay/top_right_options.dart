//==
import 'package:flutter/material.dart';
import 'package:food_inventory_tracker/model/food_item.dart';
import 'package:food_inventory_tracker/provider/food_list.dart';
import 'package:food_inventory_tracker/screens/edit_food_screen.dart';
import 'package:food_inventory_tracker/widgets/dialogs/delete_dialog.dart';
import 'package:food_inventory_tracker/widgets/dialogs/hide_item_dialog.dart';
import 'package:provider/provider.dart';

class TopRightOptions extends StatelessWidget {
  final FoodItem _foodDetail;

  const TopRightOptions(this._foodDetail, {super.key});

  @override
  Widget build(BuildContext context) {
    void _deleteItem() {
      _foodDetail.deleted = DateTime.now();
      Provider.of<FoodItemList>(context, listen: false)
          .updateDeleteFoodItem(_foodDetail);
    }

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () async {
            //Deleting Item
            return showDialog(
              context: context,
              builder: (context) => DeleteDialog(_foodDetail),
            );
          },
        ),
        IconButton(
          icon: _foodDetail.hidden
              ? const Icon(Icons.unarchive_outlined)
              : const Icon(Icons.security_outlined),
          onPressed: () async {
            //Hidding Item
            return showDialog(
              context: context,
              builder: (context) => HideItemDialog(_foodDetail),
            );
          },
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamed(EditFoodScreen.routName, arguments: _foodDetail);
          },
          icon: const Icon(Icons.edit),
        )
      ],
    );
  }
}
