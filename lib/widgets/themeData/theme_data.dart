//===
import "package:flutter/material.dart";

class MyThemeData {
  static const textTheme = TextTheme(
      titleMedium: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
      ));

  static const inputDecorationThemeDark = InputDecorationTheme(
    filled: true,
    fillColor: Color.fromARGB(255, 92, 92, 92),
    contentPadding: EdgeInsets.only(right: 5),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 145, 145, 145)),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 145, 145, 145)),
    ),
  );

  static const inputDecorationThemeLight = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.only(right: 5),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
  );

  static const colorSchemaDark = ColorScheme.dark(
    primary: Color.fromARGB(255, 255, 255, 255),
    secondary: Color.fromARGB(255, 208, 208, 208),
    error: Color.fromARGB(255, 202, 51, 40),
    background: Color.fromARGB(171, 0, 0, 0),
  );
  static const colorSchemaLight = ColorScheme.light(
    primary: Color.fromRGBO(131, 181, 247, 1),
    secondary: Color.fromRGBO(131, 181, 247, 1),
    error: Color.fromARGB(255, 202, 51, 40),
    background: Color.fromARGB(206, 158, 158, 158),
  );
}
