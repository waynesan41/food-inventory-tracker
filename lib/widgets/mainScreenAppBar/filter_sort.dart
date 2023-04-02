import "package:flutter/material.dart";
import "package:food_inventory_tracker/widgets/dialogs/sort_filter_dialog.dart";

class FilterSortMain extends StatelessWidget {
  const FilterSortMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3, top: 3, bottom: 3),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: IconButton(
        onPressed: () async {
          //Switch Theme
          return showDialog(
            context: context,
            builder: (context) => const SortFilterDialog(1),
          );
        },
        icon: const Icon(Icons.filter_alt_outlined),
      ),
    );
  }
}
