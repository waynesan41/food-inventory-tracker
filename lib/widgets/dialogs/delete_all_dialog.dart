//==

import "package:flutter/material.dart";
import "package:food_inventory_tracker/provider/food_list.dart";
import "package:provider/provider.dart";

class DeleteAllDialog extends StatefulWidget {
  const DeleteAllDialog();

  @override
  State<DeleteAllDialog> createState() => _DeleteAllDialogState();
}

class _DeleteAllDialogState extends State<DeleteAllDialog> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: loading
          ? CircularProgressIndicator()
          : const Text("Delete ALL Item!"),
      content: const Text("All item's data will be delete from phone."),
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
          child: const Text("DELETE ALL"),
          onPressed: () {
            setState(() {
              loading = true;
            });

            Provider.of<FoodItemList>(context, listen: false).deleteAllData();

            setState(() {
              loading = false;
            });
            Navigator.of(context).pop();
            // Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
