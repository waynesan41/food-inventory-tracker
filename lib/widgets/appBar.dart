import "package:flutter/material.dart";
import 'package:food_inventory_tracker/widgets/mainScreenAppBar/search_input.dart';

class TopAppBar extends AppBar {
  // const TopAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SearchInputText(),
      actions: [
        Container(
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
        ),
      ],
    );
  }
}
