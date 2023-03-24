import 'package:flutter/material.dart';
import 'package:food_inventory_tracker/model/food_item.dart';

// /data/user/0/com.example.food_inventory_tracker/app_flutter
class FoodItemList with ChangeNotifier {
  final String pathDir =
      "/data/user/0/com.example.food_inventory_tracker/app_flutter/";
  List<FoodItem> _foodItemList = [
    FoodItem(
      id: 1,
      name: "Europian Organic Farm Raise Chicken",
      description: "Rosted Chicken",
      imgUrl:
          "/data/user/0/com.example.food_inventory_tracker/app_flutter/chicken.jpg",
      addedDate: DateTime.parse("2023-01-21 20:13:04Z"),
      expireDate: DateTime.parse("2023-04-21 20:13:04Z"),
    ),
    FoodItem(
      id: 2,
      name: "Mango",
      description: "Sweet Mango",
      imgUrl:
          "/data/user/0/com.example.food_inventory_tracker/app_flutter/mango.jpg",
      addedDate: DateTime.parse("2023-02-11 08:40:04Z"),
      expireDate: DateTime.parse("2023-03-30 08:40:00Z"),
    ),
    FoodItem(
      id: 3,
      name: "Orange",
      description: "Jusy Orange",
      imgUrl:
          "/data/user/0/com.example.food_inventory_tracker/app_flutter/orange.jpg",
      addedDate: DateTime.parse("2023-02-15 00:00:00Z"),
      expireDate: DateTime.parse("2023-03-15 00:00:00Z"),
    ),
    FoodItem(
      id: 4,
      name: "Ice Cream",
      description: "Cone Ice Cream",
      imgUrl:
          "/data/user/0/com.example.food_inventory_tracker/app_flutter/iceCream.jpg",
      addedDate: DateTime.parse("2023-01-21 20:13:04Z"),
      expireDate: DateTime.parse("2023-04-21 20:13:04Z"),
    ),
    FoodItem(
      id: 8,
      name: null,
      description: "Medium Sweet Onion",
      imgUrl:
          "/data/user/0/com.example.food_inventory_tracker/app_flutter/chickenheart.jpg",
      addedDate: DateTime.parse("2023-01-21 20:13:04Z"),
      // expireDate: DateTime.parse("2023-07-21 20:13:04Z"),
    ),
    FoodItem(
      id: 5,
      name: "Tuna Fish",
      description: "Fresh Full Tuna Fish",
      imgUrl: null,
      // "/data/user/0/com.example.food_inventory_tracker/app_flutter/tuna.jpg",
      addedDate: DateTime.parse("2023-01-21 20:13:04Z"),
      // expireDate: DateTime.parse("2023-07-21 20:13:04Z"),
    ),
    FoodItem(
      id: 6,
      name: "Ramen Noddle",
      description: "Frozen Raman Noodle true flavor",
      imgUrl:
          "/data/user/0/com.example.food_inventory_tracker/app_flutter/ramen.jpg",
      addedDate: DateTime.parse("2021-01-21 20:13:04Z"),
      expireDate: DateTime.parse("2023-04-21 20:13:04Z"),
    ),
    FoodItem(
      id: 7,
      name: "Onion",
      description: "Medium Sweet Onion",
      imgUrl:
          "/data/user/0/com.example.food_inventory_tracker/app_flutter/onion.jpg",
      addedDate: DateTime.parse("2023-01-21 20:13:04Z"),
      // expireDate: DateTime.parse("2023-07-21 20:13:04Z"),
    ),
    FoodItem(
      id: 9,
      name: null,
      description: null,
      imgUrl:
          "/data/user/0/com.example.food_inventory_tracker/app_flutter/cam1.jpg",
      addedDate: DateTime.parse("2023-01-21 20:13:04Z"),
      // expireDate: DateTime.parse("2023-07-21 20:13:04Z"),
    ),
  ];

  List<FoodItem> get foodItemList {
    return [..._foodItemList];
  }

  FoodItem foodDetailById(int id) {
    return _foodItemList.firstWhere((item) => item.id == id);
  }

  void editFoodItem(int id, FoodItem updatedFood) {
    print(id);
    print(updatedFood.name);
    final prodIndex = _foodItemList.indexWhere((prod) => prod.id == id);
    _foodItemList[prodIndex] = updatedFood;
    notifyListeners();

    //Edit Item with the ID
  }
}
