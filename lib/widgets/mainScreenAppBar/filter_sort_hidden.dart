import "package:flutter/material.dart";

class FilterSortHidden extends StatelessWidget {
  const FilterSortHidden({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3, top: 3, bottom: 3),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 115, 192, 255),
          width: 3,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: IconButton(
        onPressed: () {
          //Switch Theme
        },
        color: Color.fromARGB(255, 115, 192, 255),
        icon: const Icon(Icons.filter_alt_outlined),
      ),
    );
  }
}
