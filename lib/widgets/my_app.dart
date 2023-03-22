//==========
import 'package:flutter/material.dart';
import 'package:food_inventory_tracker/provider/food_list.dart';
import 'package:food_inventory_tracker/provider/user_option_data.dart';
import 'package:food_inventory_tracker/screens/edit_food_screen.dart';
import 'package:food_inventory_tracker/screens/food_detail_screen.dart';
import 'package:food_inventory_tracker/screens/main_screen.dart';
import "package:provider/provider.dart";
import 'my_home.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => OptionData(),
        ),
        ChangeNotifierProvider(
          create: (_) => FoodItemList(),
        ),
      ],
      child: Consumer<OptionData>(builder: (ctx, optData, _) {
        return MaterialApp(
            title: 'SQFLiite Testing Gound',
            theme: ThemeData(
              textTheme: TextTheme(
                  titleMedium: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                  titleSmall: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  bodyMedium: TextStyle(
                    fontSize: 15,
                  )),
              primarySwatch: Colors.blue,
              textSelectionTheme: optData.themeState
                  ? const TextSelectionThemeData(
                      cursorColor: Colors.white,
                    )
                  : const TextSelectionThemeData(
                      cursorColor: Colors.black,
                    ),
              inputDecorationTheme: optData.themeState
                  ? const InputDecorationTheme(
                      filled: true,
                      fillColor: Color.fromARGB(255, 92, 92, 92),
                      contentPadding: EdgeInsets.only(right: 5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 145, 145, 145)),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 145, 145, 145)),
                      ),
                    )
                  : const InputDecorationTheme(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(right: 5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
              colorScheme: optData.themeState
                  ? const ColorScheme.dark(
                      primary: Color.fromARGB(255, 255, 255, 255),
                      secondary: Color.fromARGB(255, 208, 208, 208),
                      background: Color.fromARGB(171, 0, 0, 0),
                    )
                  : const ColorScheme.light(
                      primary: Colors.blueGrey,
                      secondary: Colors.blueGrey,
                      background: Color.fromARGB(206, 158, 158, 158)),
            ),
            home: MainScreen(),
            routes: {
              FoodDetailScreen.routeName: (ctx) => FoodDetailScreen(),
              EditFoodScreen.routName: (ctx) => EditFoodScreen(),
            });
      }),
    );
  }
}
