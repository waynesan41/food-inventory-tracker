import 'package:flutter/material.dart';

class SearchInputText extends StatelessWidget {
  const SearchInputText({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (ctx) {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      autofocus: false,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: "Search",
        suffixIcon: IconButton(
          onPressed: () {
            //Clear textfield
          },
          icon: Icon(Icons.clear),
        ),
      ),
    );
  }
}
