import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:food_inventory_tracker/provider/food_list.dart';

class HiddenSearchInputText extends StatefulWidget {
  const HiddenSearchInputText({super.key});

  @override
  State<HiddenSearchInputText> createState() => _HiddenSearchInputTextState();
}

class _HiddenSearchInputTextState extends State<HiddenSearchInputText> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _searchController.text =
        Provider.of<FoodItemList>(context, listen: false).getSearchHide ?? "";
    return TextField(
      controller: _searchController,
      onChanged: (value) => Provider.of<FoodItemList>(context, listen: false)
          .setSearchHide(value),
      onTapOutside: (ctx) {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      autofocus: false,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: "Hidden Search",
        suffixIcon: IconButton(
          onPressed: () {
            //Clear textfield
            _searchController.clear();
            Provider.of<FoodItemList>(context, listen: false)
                .setSearchHide(_searchController.text);
          },
          icon: const Icon(Icons.clear),
        ),
      ),
    );
  }
}
