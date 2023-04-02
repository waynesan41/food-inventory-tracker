import "package:flutter/material.dart";
import "package:food_inventory_tracker/widgets/dialogs/sort_filter_dialog.dart";

class FilterSortHidden extends StatelessWidget {
  const FilterSortHidden({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3, top: 3, bottom: 3),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 0, 140, 255),
          width: 3,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: IconButton(
        onPressed: () async {
          //Dialog For Sort Filter
          return showDialog(
            context: context,
            builder: (context) => const SortFilterDialog(2),
          );
        },
        color: const Color.fromARGB(255, 0, 140, 255),
        icon: const Icon(Icons.filter_alt_outlined),
      ),
    );
  }
}
