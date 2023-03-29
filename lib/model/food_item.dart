import 'package:flutter/material.dart';

class FoodItemFields {
  static final String id = "id";
  static final String name = "name";
  static final String description = "description";
  static final String imgUrl = "imgUrl";
  static final String addedDate = "addedDate";
  static final String expireDate = "expireDate";
  static final String hidden = "hidden";
  static final String deleted = "deleted";
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
