//===
import 'package:flutter/material.dart';

import 'package:food_inventory_tracker/model/food_item.dart';
import 'package:food_inventory_tracker/widgets/dialogs/forever_delete_dialog.dart';
import 'package:food_inventory_tracker/widgets/dialogs/recover_deleted.dart';
import 'package:food_inventory_tracker/widgets/dialogs/save_image_dialog.dart';

class DeletedOptionButtons extends StatelessWidget {
  const DeletedOptionButtons(this._foodDetail, {super.key});
  final FoodItem _foodDetail;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(15),
            shape: BoxShape.rectangle,
          ),
          child: IconButton(
            color: Colors.green,
            icon: const Icon(Icons.save_alt),
            onPressed: () async {
              //Save Image
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
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              //Delete Forever
              return showDialog(
                context: context,
                builder: (context) => ForeverDeleteDialog(_foodDetail),
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
            icon: const Icon(Icons.drive_file_move_rtl_outlined),
            onPressed: () async {
              return showDialog(
                context: context,
                builder: (context) => RecoverDialog(_foodDetail),
              );
            },
          ),
        ),
      ],
    );
  }
}
