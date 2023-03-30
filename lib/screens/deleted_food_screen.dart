//==
import "package:flutter/material.dart";
import "package:food_inventory_tracker/widgets/dialogs/delete_all_dialog.dart";
import "package:provider/provider.dart";

import "package:food_inventory_tracker/provider/food_list.dart";
import "package:food_inventory_tracker/widgets/mainScreenAppBar/drawer_menu.dart";
import "package:food_inventory_tracker/widgets/foodItemDisplay/deleted_food_card_list.dart";

class DeletedScreen extends StatelessWidget {
  const DeletedScreen({super.key});

  static const routName = "/deleted-food-item";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deleted Items"),
        actions: [
          Container(
            margin: const EdgeInsets.only(top: 6, bottom: 6, right: 6),
            child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 202, 36, 24)),
              ),
              icon: const Icon(Icons.delete_forever_outlined),
              label: const Text("Delete All"),
              onPressed: () async {
                //Delete All Forever

                return showDialog(
                  context: context,
                  builder: (context) => DeleteAllDialog(),
                );
              },
            ),
          )
        ],
      ),
      drawer: DrawerMenu(),
      body: FutureBuilder(
        future: Provider.of<FoodItemList>(context, listen: false)
            .fetchDeletedFoodItemList(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<FoodItemList>(
                    builder: (context, value, _) => DeletedFoodCardList(),
                  ),
      ),
    );
  }
}
