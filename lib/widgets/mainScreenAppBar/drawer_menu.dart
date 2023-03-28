import "package:flutter/material.dart";
import "package:food_inventory_tracker/screens/deleted_food_screen.dart";
import "package:food_inventory_tracker/screens/hidden_food_screen.dart";
import "package:food_inventory_tracker/screens/main_screen.dart";
import "package:food_inventory_tracker/screens/statistics_screen.dart";
import "package:provider/provider.dart";
import "package:food_inventory_tracker/provider/user_option_data.dart";

class DrawerMenu extends StatelessWidget {
  // const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final _currTheme =
        Provider.of<OptionData>(context, listen: false).themeState;
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("More Option"),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.food_bank_outlined),
            title: Text("All Food"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.security_outlined),
            title: Text("Hidden Food"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(HiddenFoodScreen.routName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.delete_outline_outlined),
            title: Text("Deleted Item"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(DeletedScreen.routName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.stacked_bar_chart_sharp),
            title: Text("Statistics"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(StatisticsScreen.routName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Row(
              children: [
                /* ElevatedButton(
                    onPressed: () {
                      Provider.of<OptionData>(context, listen: false)
                          .switchTheme();
                      print(Provider.of<OptionData>(context, listen: false)
                          .themeState);
                    },
                    child: Text("Change")), */
                Switch(
                  value: _currTheme,
                  onChanged: (_) {
                    Provider.of<OptionData>(context, listen: false)
                        .switchTheme();
                  },
                ),
                Text("Theme"),
              ],
            ),
            trailing: Icon(Icons.light_mode_outlined),
            onTap: () {
              /* Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout(); */
            },
          ),
        ],
      ),
    );
  }
}
