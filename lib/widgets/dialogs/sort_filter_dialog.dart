//==
import "package:flutter/material.dart";
import "package:food_inventory_tracker/provider/food_list.dart";
import "package:provider/provider.dart";

enum RadioOption {
  sortOldToNew,
  sortNewToOld,
  expireCloseToFar,
  expireFarToClose,
}

class SortFilterDialog extends StatefulWidget {
  const SortFilterDialog(this.type, {super.key});
  final int type;
  @override
  State<SortFilterDialog> createState() => _SortFilterDialogState();
}

class _SortFilterDialogState extends State<SortFilterDialog> {
  bool init = false;
  RadioOption? _option;
  @override
  void initState() {
    init = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (init) {
      int sortVal =
          Provider.of<FoodItemList>(context).getSortValue(widget.type);
      setState(() {
        _option = RadioOption.values[sortVal];
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Sort Item"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<RadioOption>(
            title: const Text(
              'Added Date\nOld To New',
              style: TextStyle(fontSize: 17),
            ),
            onChanged: (value) {
              setState(() {
                _option = value;
              });
            },
            value: RadioOption.sortOldToNew,
            groupValue: _option,
          ),
          const Divider(),
          RadioListTile<RadioOption>(
            title: const Text(
              'Added Date\nNew To Old',
              style: TextStyle(fontSize: 17),
            ),
            onChanged: (value) {
              setState(() {
                _option = value;
              });
            },
            value: RadioOption.sortNewToOld,
            groupValue: _option,
          ),
          const Divider(),
          RadioListTile<RadioOption>(
            title: const Text(
              'Expire Date\nClose To Far',
              style: TextStyle(fontSize: 17),
            ),
            onChanged: (value) {
              setState(() {
                _option = value;
              });
            },
            value: RadioOption.expireCloseToFar,
            groupValue: _option,
          ),
          const Divider(),
          RadioListTile<RadioOption>(
            title: const Text(
              'Expire Date\nFar To Close',
              style: TextStyle(fontSize: 17),
            ),
            onChanged: (value) {
              setState(() {
                _option = value;
              });
            },
            value: RadioOption.expireFarToClose,
            groupValue: _option,
          ),
        ],
      ),
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
              Colors.blue[600],
            ),
          ),
          child:
              const Text("APPLY Filter", style: TextStyle(color: Colors.white)),
          onPressed: () {
            //Fetch and sorted Filter
            Provider.of<FoodItemList>(context, listen: false)
                .setSort(_option!.index, widget.type);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
