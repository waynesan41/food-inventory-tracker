//======
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_inventory_tracker/database/db_helper.dart';
import 'package:food_inventory_tracker/model/food_item.dart';

class FoodItemList with ChangeNotifier {
  List<FoodItem> _foodItemList = [];
  List<FoodItem> _deletedItem = [];
  List<FoodItem> _hiddenItem = [];
  String? _search;
  String? _searchHide;

  void setSearch(String? searchControl) {
    _search = searchControl;
    notifyListeners();
  }

  void setSearchHide(String? searchControl) {
    _searchHide = searchControl;
    notifyListeners();
  }

  String? get getSearch {
    return _search;
  }

  String? get getSearchHide {
    return _searchHide;
  }

  List<FoodItem> get foodItemList {
    return _foodItemList.where((element) {
      if (_search == null) return true;
      if (element.name != null) {
        return element.name!.toLowerCase().contains(_search!.toLowerCase());
      } else {
        return false;
      }
    }).toList();
  }

  List<FoodItem> get deletedFoodItemList {
    return [..._deletedItem];
  }

  List<FoodItem> get hiddenItemList {
    return _hiddenItem.where((element) {
      if (_searchHide == null) return true;
      if (element.name != null) {
        return element.name!.toLowerCase().contains(_searchHide!.toLowerCase());
      } else {
        return false;
      }
    }).toList();
  }

  // Get Sorted Food ==============================================
  Future<void> fetchAndSetFoodItemList() async {
    await DBHelper.getData().then(
      (value) {
        _foodItemList = value.map(
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
              hidden: item[FoodItemFields.hidden] == 0 ? false : true,
              deleted: item[FoodItemFields.deleted] == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(
                      item[FoodItemFields.deleted]),
            );
          },
        ).toList();
      },
    ).then(
      (_) {
        notifyListeners();
      },
    );
  }

  Future<void> fetchDeletedFoodItemList() async {
    await DBHelper.getDeletedData().then(
      (value) {
        _deletedItem = value.map(
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
              hidden: item[FoodItemFields.hidden] == 0 ? false : true,
              deleted: item[FoodItemFields.deleted] == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(
                      item[FoodItemFields.deleted]),
            );
          },
        ).toList();
      },
    ).then(
      (_) {
        notifyListeners();
      },
    );
  }

  Future<void> fetchAndSetHiddenFoodItemList() async {
    await DBHelper.getHiddedData().then(
      (value) {
        _hiddenItem = value.map(
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
              hidden: item[FoodItemFields.hidden] == 0 ? false : true,
              deleted: item[FoodItemFields.deleted] == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(
                      item[FoodItemFields.deleted]),
            );
          },
        ).toList();
      },
    ).then(
      (_) {
        notifyListeners();
      },
    );
  }

  // Find Item By ID ==============================================
  FoodItem foodDetailById(int id) {
    return _foodItemList.firstWhere((item) => item.id == id,
        orElse: () => FoodItem(id: -1, addedDate: DateTime.now()));
  }

  FoodItem deletedFoodById(int id) {
    return _deletedItem.firstWhere((item) => item.id == id,
        orElse: () => FoodItem(id: -1, addedDate: DateTime.now()));
  }

  FoodItem hiddenFoodById(int id) {
    return _hiddenItem.firstWhere((item) => item.id == id,
        orElse: () => FoodItem(id: -1, addedDate: DateTime.now()));
  }

  //Editing Item ==============================================
  Future<void> editFoodItem(int id, FoodItem updatedFood) async {
    print(id);
    print(updatedFood.name);
    final result = await DBHelper.updateData(id, updatedFood);
    print("RESULTT: $result");
    if (result == 1) {
      if (updatedFood.hidden) {
        final prodIndex = _hiddenItem.indexWhere((prod) => prod.id == id);
        _hiddenItem[prodIndex] = updatedFood;
      } else {
        final prodIndex = _foodItemList.indexWhere((prod) => prod.id == id);
        _foodItemList[prodIndex] = updatedFood;
      }

      notifyListeners();
    }
  }

  // Add New Food Item =================================================
  Future<void> addFoodItem(FoodItem newFood) async {
    final result = await DBHelper.addData(newFood);
    print("NEWWWWWWWWW ID: $result");

    final insertFood = FoodItem(
      id: result,
      name: newFood.name,
      description: newFood.description,
      imgUrl: newFood.imgUrl,
      addedDate: newFood.addedDate,
      expireDate: newFood.expireDate,
      hidden: newFood.hidden,
    );
    newFood.hidden
        ? _hiddenItem.insert(0, insertFood)
        : _foodItemList.insert(0, insertFood);
    notifyListeners();
  }

  // =====================================================
  // ============ Deleting Section =====================
  // =====================================================
  // Deleting Item ====================================================
  Future<void> updateDeleteFoodItem(FoodItem deleteFood) async {
    final result = await DBHelper.updateDelete(deleteFood);

    if (deleteFood.deleted == null) {
      deleteFood.hidden
          ? _hiddenItem.insert(0, deleteFood)
          : _foodItemList.insert(0, deleteFood);
      _deletedItem.remove(deleteFood);
    } else {
      deleteFood.hidden
          ? _hiddenItem.remove(deleteFood)
          : _foodItemList.remove(deleteFood);
      _deletedItem.add(deleteFood);
    }
    notifyListeners();
  }

  // Delete Item Data From Phone ==================================================
  Future<void> deleteFoodItemForever(FoodItem deleteFood) async {
    final result = await DBHelper.deleteCompleteData(deleteFood);
    if (result == 1) {
      if (deleteFood.imgUrl != null) {
        try {
          final imgFile = File(deleteFood.imgUrl.toString());
          await imgFile.delete();
        } catch (e) {
          print(e);
        }
      }
      _deletedItem.remove(deleteFood);
      notifyListeners();
    }
  }

  // Forever Delete Item Item ==========================================
  void deleteAllData() async {
    for (var i = 0; i < _deletedItem.length; i++) {
      print("DELEEEETTTINGGGGGG ${_deletedItem[i].id}");
      final result = await DBHelper.deleteCompleteData(_deletedItem[i]);
      print("SSSSSSSSSSSSSSSS: $result");
      if (result == 1) {
        print("RRRRRRRRRRRRRRRRR: $result");
        if (_deletedItem[i].imgUrl != null) {
          print("DDDDDDDDEEELETING FILE:");
          final imgFile = File(_deletedItem[i].imgUrl.toString());
          imgFile.deleteSync();
        }
      }
    }
    _deletedItem.clear();
    notifyListeners();
    return;
  }

  // =====================================================
  // ============== Hidding  Section =====================
  // =====================================================
  // Hidding Item ======================================================
  Future<void> hideItemUpdate(FoodItem hideFood) async {
    final result = await DBHelper.hideItemData(hideFood);

    if (result == 1) {
      if (hideFood.hidden) {
        _foodItemList.remove(hideFood);
        _hiddenItem.insert(0, hideFood);
      } else {
        _foodItemList.insert(0, hideFood);
        _hiddenItem.remove(hideFood);
      }
      notifyListeners();
    }
  }
} // End of Food List [DON'T DELETE]
