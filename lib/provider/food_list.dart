import 'package:flutter/material.dart';
import 'package:food_inventory_tracker/database/db_helper.dart';
import 'package:food_inventory_tracker/model/food_item.dart';

class FoodItemList with ChangeNotifier {
  List<FoodItem> _foodItemList = [];
  List<FoodItem> _deletedItem = [];
  List<FoodItem> _hiddenItem = [];

  List<FoodItem> get foodItemList {
    return [..._foodItemList];
  }

  // Get Sorted Food ==============================================
  Future<void> fetchAndSetFoodItemList() async {
    final dataList = await DBHelper.getData();

    _foodItemList = dataList.map(
      (item) {
        print(item);
        return FoodItem(
          id: item[FoodItemFields.id],
          name: item[FoodItemFields.name],
          description: item[FoodItemFields.description],
          imgUrl: item[FoodItemFields.imgUrl],
          addedDate: DateTime.fromMillisecondsSinceEpoch(
              item[FoodItemFields.addedDate]),
          expireDate: item[FoodItemFields.expireDate] == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(
                  item[FoodItemFields.expireDate]),
          deleted: item[FoodItemFields.deleted] == 0 ? false : true,
          hidden: item[FoodItemFields.hidden] == 0 ? false : true,
        );
      },
    ).toList();

    notifyListeners();
  }

  // Find Item By ID ==============================================
  FoodItem foodDetailById(int id) {
    return _foodItemList.firstWhere((item) => item.id == id);
  }

  //Editing Item ==============================================
  Future<void> editFoodItem(int id, FoodItem updatedFood) async {
    print(id);
    print(updatedFood.name);
    final result = await DBHelper.updateData(id, updatedFood);
    print("RESULTT: $result");
    if (result == 1) {
      final prodIndex = _foodItemList.indexWhere((prod) => prod.id == id);
      _foodItemList[prodIndex] = updatedFood;

      notifyListeners();
    }
  }

  // Deleting Item =====================================================

  // Hidding Item ======================================================

  // Forever Delete Item Item ==========================================

  // Add New Food Item =================================================
}
