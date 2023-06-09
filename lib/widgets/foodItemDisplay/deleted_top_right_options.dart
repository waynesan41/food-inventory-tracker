//==
import 'package:flutter/material.dart';
import 'package:food_inventory_tracker/model/food_item.dart';

import 'package:food_inventory_tracker/widgets/dialogs/forever_delete_dialog.dart';
import 'package:food_inventory_tracker/widgets/dialogs/recover_deleted.dart';

class DeletedTopRightOption extends StatelessWidget {
  final FoodItem _foodDetail;
  const DeletedTopRightOption(this._foodDetail, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: const Icon(Icons.delete_forever_outlined),
            onPressed: () async {
              //Delete Forever With ID
              return showDialog(
                context: context,
                builder: (context) => ForeverDeleteDialog(_foodDetail),
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: const Icon(Icons.drive_file_move_rtl_outlined),
            onPressed: () async {
              //Undo Delete, set Delete to Null
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
