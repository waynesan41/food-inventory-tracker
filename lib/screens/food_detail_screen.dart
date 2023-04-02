//==========
import "dart:io";

import "package:intl/intl.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "package:food_inventory_tracker/widgets/foodItemDisplay/deleted_option_buttons.dart";
import "package:food_inventory_tracker/widgets/foodItemDisplay/deleted_top_right_options.dart";
import "package:food_inventory_tracker/widgets/foodItemDisplay/top_right_options.dart";

import "package:food_inventory_tracker/model/food_item.dart";
import "package:food_inventory_tracker/widgets/foodItemDisplay/image_full_screen.dart";
import "package:food_inventory_tracker/widgets/foodItemDisplay/option_buttons.dart";

import "package:food_inventory_tracker/provider/food_list.dart";

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({super.key});
  static const routeName = "/food-detail-screen";

  @override
  Widget build(BuildContext context) {
    final foodId = ModalRoute.of(
      context,
    )?.settings.arguments as FoodItem;
    late FoodItem foodDetail;
    if (foodId.deleted == null) {
      foodDetail = foodId.hidden
          ? Provider.of<FoodItemList>(context).hiddenFoodById(foodId.id)
          : Provider.of<FoodItemList>(context).foodDetailById(foodId.id);
    } else {
      foodDetail =
          Provider.of<FoodItemList>(context).deletedFoodById(foodId.id);
    }

    return foodDetail.id == -1
        ? const Text("nothing")
        : Scaffold(
            appBar: AppBar(
              title: Text(foodDetail.name ?? "No Name"),
              actions: [
                foodDetail.deleted == null
                    ? TopRightOptions(foodDetail)
                    : DeletedTopRightOption(foodDetail)
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
                      foodDetail.name ?? "No Name",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Divider(
                      color: foodDetail.deleted != null
                          ? Theme.of(context).colorScheme.error
                          : foodDetail.hidden
                              ? const Color.fromARGB(255, 144, 202, 249)
                              : Theme.of(context).colorScheme.secondary,
                      height: 15,
                      thickness: 3,
                    ),
                    Column(
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
                            Text(DateFormat.yMd()
                                .add_jm()
                                .format(foodDetail.addedDate)),
                            Text(foodDetail.expireDate != null
                                ? DateFormat.yMd()
                                    .format(foodDetail.expireDate!)
                                : "Not Added"),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: foodDetail.deleted == null
                          ? OptionButtons(foodDetail)
                          : DeletedOptionButtons(foodDetail),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
                      // child: InteractiveViewer(
                      //   constrained: true,
                      child: foodDetail.imgUrl == null
                          ? const Image(
                              image: AssetImage('assets/images/noimage.jpg'),
                            )
                          : GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return ImageFullScreen(foodDetail.imgUrl);
                                }));
                              },
                              child: Hero(
                                tag: "imageHero",
                                child: Image.file(
                                  File(foodDetail.imgUrl.toString()),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),

                      // ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
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
                          Text(foodDetail.description ?? "No Description"),

                          //=====
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
