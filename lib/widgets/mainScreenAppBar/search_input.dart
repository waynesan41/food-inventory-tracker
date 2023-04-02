import 'package:flutter/material.dart';
import 'package:food_inventory_tracker/provider/food_list.dart';
import 'package:provider/provider.dart';

class SearchInputText extends StatefulWidget {
  const SearchInputText({super.key});

  @override
  State<SearchInputText> createState() => _SearchInputTextState();
}

class _SearchInputTextState extends State<SearchInputText> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _searchController.text =
        Provider.of<FoodItemList>(context, listen: false).getSearch ?? "";
    return TextField(
      controller: _searchController,
      onChanged: (value) =>
          Provider.of<FoodItemList>(context, listen: false).setSearch(value),
      onTapOutside: (ctx) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      autofocus: false,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: "Search",
        suffixIcon: IconButton(
          onPressed: () {
            //Clear textfield
            _searchController.clear();
            Provider.of<FoodItemList>(context, listen: false)
                .setSearch(_searchController.text);
          },
          icon: const Icon(Icons.clear),
        ),
      ),
    );
  }
}
