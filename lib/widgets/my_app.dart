//==========
import 'package:flutter/material.dart';
import 'package:food_inventory_tracker/screens/add_food_screen.dart';
import 'package:food_inventory_tracker/screens/deleted_food_screen.dart';
import 'package:food_inventory_tracker/screens/hidden_food_screen.dart';
import 'package:food_inventory_tracker/screens/statistics_screen.dart';
import 'package:food_inventory_tracker/widgets/themeData/theme_data.dart';
import "package:provider/provider.dart";

import 'package:food_inventory_tracker/provider/food_list.dart';
import 'package:food_inventory_tracker/provider/user_option_data.dart';
import 'package:food_inventory_tracker/screens/edit_food_screen.dart';
import 'package:food_inventory_tracker/screens/food_detail_screen.dart';
import 'package:food_inventory_tracker/screens/main_screen.dart';

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
            title: 'Food Inventory Tracker',
            theme: ThemeData(
              textTheme: MyThemeData.textTheme,
              textSelectionTheme: optData.themeState
                  ? const TextSelectionThemeData(
                      cursorColor: Colors.white,
                    )
                  : const TextSelectionThemeData(
                      cursorColor: Colors.black,
                    ),
              inputDecorationTheme: optData.themeState
                  ? MyThemeData.inputDecorationThemeDark
                  : MyThemeData.inputDecorationThemeLight,
              colorScheme: optData.themeState
                  ? MyThemeData.colorSchemaDark
                  : MyThemeData.colorSchemaLight,
            ),
            home: DeletedScreen(),
            routes: {
              MainScreen.routeName: (ctx) => MainScreen(),
              FoodDetailScreen.routeName: (ctx) => FoodDetailScreen(),
              EditFoodScreen.routName: (ctx) => EditFoodScreen(),
              AddFoodScreen.routeName: (ctx) => AddFoodScreen(),
              HiddenFoodScreen.routName: (ctx) => HiddenFoodScreen(),
              DeletedScreen.routName: (ctx) => DeletedScreen(),
              StatisticsScreen.routName: (ctx) => StatisticsScreen(),
            });
      }),
    );
  }
}
