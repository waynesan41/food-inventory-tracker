//==========
import "dart:io";

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:intl/intl.dart";

import "package:food_inventory_tracker/provider/food_list.dart";
import "package:food_inventory_tracker/screens/edit_food_screen.dart";

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({super.key});
  static const routeName = "/food-detail-screen";

  @override
  Widget build(BuildContext context) {
    final foodId = ModalRoute.of(context)?.settings.arguments as int;
    final foodDetail = Provider.of<FoodItemList>(context, listen: false)
        .foodDetailById(foodId);
    return Scaffold(
      appBar: AppBar(
        title: Text("${foodDetail.name}"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.security_outlined),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditFoodScreen.routName, arguments: foodDetail);
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Column(
            children: [
              Text(
                "${foodDetail.name}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Divider(),
              Container(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Added Date (${DateTime.now().difference(foodDetail.addedDate).inDays.toString()} days ago)",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        "Expire Date",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "${DateFormat.yMd().add_jm().format(foodDetail.addedDate)}"),
                      Text(
                          "${foodDetail.expireDate != null ? DateFormat.yMd().format(foodDetail.expireDate!) : "Not Added"}"),
                    ],
                  ),
                ],
              )),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                // child: InteractiveViewer(
                //   constrained: true,
                child: foodDetail.imgUrl == null
                    ? Image(
                        image: AssetImage('assets/images/noimage.jpg'),
                      )
                    : Image.file(
                        File(foodDetail.imgUrl.toString()),
                        fit: BoxFit.contain,
                      ),
                // ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 10,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Description",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Text("${foodDetail.description ?? "No Description"}")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
