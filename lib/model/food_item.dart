import 'package:flutter/material.dart';

class FoodItemFields {
  static const String id = "id";
  static const String name = "name";
  static const String description = "description";
  static const String imgUrl = "imgUrl";
  static const String addedDate = "addedDate";
  static const String expireDate = "expireDate";
  static const String hidden = "hidden";
  static const String deleted = "deleted";
}

class FoodItem with ChangeNotifier {
  int id;
  String? name;
  String? description;
  String? imgUrl;
  DateTime addedDate;
  DateTime? expireDate;
  bool hidden;
  DateTime? deleted;

  FoodItem({
    required this.id,
    this.name,
    this.description,
    this.imgUrl,
    required this.addedDate,
    this.expireDate,
    this.hidden = false,
    this.deleted,
  });
}
