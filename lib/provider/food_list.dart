//======
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:food_inventory_tracker/database/db_helper.dart';
import 'package:food_inventory_tracker/model/food_item.dart';

class FoodItemList with ChangeNotifier {
  List<FoodItem> _foodItemList = [];
  List<FoodItem> _deletedItem = [];
  List<FoodItem> _hiddenItem = [];
  String? _search;
  String? _searchHide;
  int? _sort;
  int? _sortHide;

  // =====================================================
  // ============ Search and Get Section =================
  // =====================================================
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
      if (_search == null || _search == "") return true;
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
      if (_searchHide == null || _searchHide == "") return true;
      if (element.name != null) {
        return element.name!.toLowerCase().contains(_searchHide!.toLowerCase());
      } else {
        return false;
      }
    }).toList();
  }

  // =====================================================
  // ============ Fetch and Set Section =====================
  // =====================================================
  // Get Sorted Types ========================================================
  void setSort(int sortVal, int type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (type == 1) {
      _sort = sortVal;
      await prefs.setInt('sort', sortVal).then(
        (value) {
          fetchAndSetFoodItemList();
          notifyListeners();
        },
      );
    } else if (type == 2) {
      _sortHide = sortVal;
      await prefs.setInt('sortHide', sortVal).then(
        (value) {
          fetchAndSetHiddenFoodItemList();
          notifyListeners();
        },
      );
    }
  }

  int getSortValue(int type) {
    if (type == 1) {
      return _sort ?? 0;
    } else {
      return _sortHide ?? 0;
    }
  }

  // Get Sorted for Hidden  Types ============================================
  Future<int> getSort() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('sortHide') == null) {
      prefs.setInt('sortHide', 0);
      _sortHide = 0;
    } else {
      _sortHide = prefs.getInt('sortHide');
    }
    if (prefs.getInt('sort') == null) {
      prefs.setInt('sort', 0);
      _sort = 0;
    } else {
      _sort = prefs.getInt('sort');
    }
    return 1;
  }

  // Get Sorted Food ==============================================
  Future<void> fetchAndSetFoodItemList() async {
    await getSort().then(
      (value) {
        DBHelper.getData(_sort).then(
          (value) {
            _foodItemList = value.map(
              (item) {
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
      },
    );
  }

  Future<void> fetchAndSetHiddenFoodItemList() async {
    await getSort().then(
      (_) {
        DBHelper.getHiddedData(_sortHide).then(
          (value) {
            _hiddenItem = value.map(
              (item) {
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
      },
    );
  }

  Future<void> fetchDeletedFoodItemList() async {
    await DBHelper.getDeletedData().then(
      (value) {
        _deletedItem = value.map(
          (item) {
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

  // =====================================================
  // ============ Edit | Add | Update Section ============
  // =====================================================
  //Editing Item ==============================================
  Future<void> editFoodItem(int id, FoodItem updatedFood) async {
    final result = await DBHelper.updateData(id, updatedFood);

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

    if (result == 1) {
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
          //Error
        }
      }
      _deletedItem.remove(deleteFood);
      notifyListeners();
    }
  }

  // Forever Delete Item Item ==========================================
  void deleteAllData() async {
    for (var i = 0; i < _deletedItem.length; i++) {
      final result = await DBHelper.deleteCompleteData(_deletedItem[i]);

      if (result == 1) {
        if (_deletedItem[i].imgUrl != null) {
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
