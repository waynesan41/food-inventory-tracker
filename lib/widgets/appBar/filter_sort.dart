import "package:flutter/material.dart";

class FilterSortMain extends StatelessWidget {
  const FilterSortMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3, top: 3, bottom: 3),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: IconButton(
        onPressed: () {
          //Switch Theme
        },
        icon: const Icon(Icons.filter_alt_outlined),
      ),
    );
  }
}
