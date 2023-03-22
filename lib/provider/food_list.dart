import 'package:flutter/material.dart';
import 'package:food_inventory_tracker/model/food_item.dart';

class FoodItemList with ChangeNotifier {
  List<FoodItem> _foodItemList = [
    FoodItem(
      id: 1,
      name: "Europian Organic Farm Raise Chicken",
      description: "Rosted Chicken",
      imgUrl:
          "https://assets.epicurious.com/photos/62f16ed5fe4be95d5a460eed/5:4/w_4770,h_3816,c_limit/RoastChicken_RECIPE_080420_37993.jpg",
      addedDate: DateTime.parse("2023-01-21 20:13:04Z"),
      expireDate: DateTime.parse("2023-04-21 20:13:04Z"),
    ),
    FoodItem(
      id: 2,
      name: "Mango",
      description: "Sweet Mango",
      imgUrl:
          "https://images.immediate.co.uk/production/volatile/sites/30/2018/08/mango-fee0d79-e1648560084294.jpg",
      addedDate: DateTime.parse("2023-02-11 08:40:04Z"),
      expireDate: DateTime.parse("2023-03-30 08:40:00Z"),
    ),
    FoodItem(
      id: 3,
      name: "Orange",
      description: "Jusy Orange",
      imgUrl:
          "https://theinnerworld.in/wp-content/uploads/2018/01/orange-fruit-vitamins-healthy-eating-52533.jpeg",
      addedDate: DateTime.parse("2023-02-15 00:00:00Z"),
      expireDate: DateTime.parse("2023-03-15 00:00:00Z"),
    ),
    FoodItem(
      id: 4,
      name: "Ice Cream",
      description: "Cone Ice Cream",
      imgUrl:
          "https://belusaweb.s3.amazonaws.com/product-images/colors/Ice%20Cream_ice-cream-squeezie-al26442-gallery-1.jpg",
      addedDate: DateTime.parse("2023-01-21 20:13:04Z"),
      expireDate: DateTime.parse("2023-04-21 20:13:04Z"),
    ),
    FoodItem(
      id: 8,
      name: null,
      description: "Medium Sweet Onion",
      imgUrl:
          "https://healthyrecipesblogs.com/wp-content/uploads/2014/06/chicken-hearts-featured-2022.jpg",
      addedDate: DateTime.parse("2023-01-21 20:13:04Z"),
      // expireDate: DateTime.parse("2023-07-21 20:13:04Z"),
    ),
    FoodItem(
      id: 5,
      name: "Tuna Fish",
      description: "Fresh Full Tuna Fish",
      imgUrl:
          "https://upload.wikimedia.org/wikipedia/commons/1/18/Bluefin-big.jpg",
      addedDate: DateTime.parse("2023-01-21 20:13:04Z"),
      // expireDate: DateTime.parse("2023-07-21 20:13:04Z"),
    ),
    FoodItem(
      id: 6,
      name: "Ramen Noddle",
      description: "Frozen Raman Noodle true flavor",
      imgUrl:
          "https://www.tastingtable.com/img/gallery/spruced-up-instant-ramen-and-fixings-recipe-upgrade/spruced-up-instant-ramen-and-fixings-1669064166.webp",
      addedDate: DateTime.parse("2021-01-21 20:13:04Z"),
      expireDate: DateTime.parse("2023-04-21 20:13:04Z"),
    ),
    FoodItem(
      id: 7,
      name: "Onion",
      description: "Medium Sweet Onion",
      imgUrl:
          "https://target.scene7.com/is/image/Target/GUEST_5d908f32-b2f6-4bc9-9156-1c8a7c1df9c5?wid=488&hei=488&fmt=pjpeg",
      addedDate: DateTime.parse("2023-01-21 20:13:04Z"),
      // expireDate: DateTime.parse("2023-07-21 20:13:04Z"),
    ),
    FoodItem(
      id: 9,
      name: null,
      description: null,
      imgUrl:
          "https://target.scene7.com/is/image/Target/GUEST_5d908f32-b2f6-4bc9-9156-1c8a7c1df9c5?wid=488&hei=488&fmt=pjpeg",
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

  void editFoodItem(
    int id,
    String? name,
    String? description,
    String? imgUrl,
    DateTime? expireDate,
    bool hidden,
    bool deleted,
  ) {
    print(id);
    //Edit Item with the ID
  }
}
