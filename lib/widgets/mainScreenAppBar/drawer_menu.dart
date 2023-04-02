import "package:flutter/material.dart";
import "package:food_inventory_tracker/screens/deleted_food_screen.dart";
import "package:food_inventory_tracker/screens/hidden_food_screen.dart";
import "package:food_inventory_tracker/screens/main_screen.dart";
import "package:food_inventory_tracker/screens/statistics_screen.dart";
import "package:provider/provider.dart";
import "package:food_inventory_tracker/provider/user_option_data.dart";

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final _currTheme =
        Provider.of<OptionData>(context, listen: false).themeState;
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text("More Option"),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.food_bank_outlined),
            title: const Text("All Food"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.security_outlined),
            title: const Text("Hidden Food"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(HiddenFoodScreen.routName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete_outline_outlined),
            title: const Text("Deleted Item"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(DeletedScreen.routName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.stacked_bar_chart_sharp),
            title: const Text("Statistics"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(StatisticsScreen.routName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: Row(
              children: [
                Switch(
                  value: _currTheme,
                  onChanged: (_) {
                    Provider.of<OptionData>(context, listen: false)
                        .switchTheme();
                  },
                ),
                const Text("Theme"),
              ],
            ),
            trailing: const Icon(Icons.light_mode_outlined),
          ),
        ],
      ),
    );
  }
}
