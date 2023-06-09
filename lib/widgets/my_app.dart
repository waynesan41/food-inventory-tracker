//==========
import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import 'package:food_inventory_tracker/provider/statistics.dart';
import 'package:food_inventory_tracker/screens/add_food_screen.dart';
import 'package:food_inventory_tracker/screens/deleted_food_screen.dart';
import 'package:food_inventory_tracker/screens/hidden_food_screen.dart';
import 'package:food_inventory_tracker/screens/statistics_screen.dart';
import 'package:food_inventory_tracker/widgets/themeData/theme_data.dart';

import 'package:food_inventory_tracker/provider/food_list.dart';
import 'package:food_inventory_tracker/provider/user_option_data.dart';
import 'package:food_inventory_tracker/screens/edit_food_screen.dart';
import 'package:food_inventory_tracker/screens/food_detail_screen.dart';
import 'package:food_inventory_tracker/screens/main_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.pref});
  final pref;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => OptionData(pref),
        ),
        ChangeNotifierProvider(
          create: (_) => FoodItemList(pref),
        ),
        ChangeNotifierProvider(
          create: (_) => StatisticsList(),
        ),
      ],
      child: Consumer<OptionData>(builder: (ctx, optData, _) {
        optData.fetchAndSetUserTheme();
        final mytheme = optData.themeState;
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Food Inventory Tracker',
            theme: ThemeData(
              textTheme: MyThemeData.textTheme,
              textSelectionTheme: mytheme
                  ? const TextSelectionThemeData(
                      cursorColor: Colors.white,
                    )
                  : const TextSelectionThemeData(
                      cursorColor: Colors.black,
                    ),
              inputDecorationTheme: mytheme
                  ? MyThemeData.inputDecorationThemeDark
                  : MyThemeData.inputDecorationThemeLight,
              colorScheme: mytheme
                  ? MyThemeData.colorSchemaDark
                  : MyThemeData.colorSchemaLight,
            ),
            home: const MainScreen(),
            routes: {
              MainScreen.routeName: (ctx) => const MainScreen(),
              FoodDetailScreen.routeName: (ctx) => const FoodDetailScreen(),
              EditFoodScreen.routName: (ctx) => const EditFoodScreen(),
              AddFoodScreen.routeName: (ctx) => const AddFoodScreen(),
              HiddenFoodScreen.routName: (ctx) => const HiddenFoodScreen(),
              DeletedScreen.routName: (ctx) => const DeletedScreen(),
              StatisticsScreen.routName: (ctx) => const StatisticsScreen(),
            });
      }),
    );
  }
}
