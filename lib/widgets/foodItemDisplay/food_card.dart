import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_inventory_tracker/model/food_item.dart';
import 'package:food_inventory_tracker/screens/food_detail_screen.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    final foodOne = Provider.of<FoodItem>(context, listen: false);
    return GestureDetector(
      onTap: () {
        print(foodOne.id);
        Navigator.of(context).pushNamed(
          FoodDetailScreen.routeName,
          arguments: foodOne,
        );
      },
      child: ClipRRect(
        /* decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.blueAccent,
          ),
        ), */
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: foodOne.imgUrl == null
              ? Image(
                  image: AssetImage('assets/images/noimage.jpg'),
                )
              : Image.file(
                  File(foodOne.imgUrl.toString()),
                  fit: BoxFit.cover,
                ),
          footer: Container(
            padding: EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: foodOne.name == null
                      ? Text("")
                      : Text(foodOne.name.toString()),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                          "Days: ${DateTime.now().difference(foodOne.addedDate).inDays.toString()}"),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(
                          "Expire:${foodOne.expireDate == null ? "NA" : foodOne.expireDate!.difference(DateTime.now()).inDays.toString()}"),
                    ),
                  ],
                )

                // Text(foodOne.addedDate.difference(DateTime.now()).toString()),
              ],
            ),
          ),
        ),
      ),
    );

    // return Text(foodOne.name ?? "Name");
  }
}
