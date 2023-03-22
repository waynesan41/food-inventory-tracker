import 'package:flutter/material.dart';

class FoodItem with ChangeNotifier {
  final int id;
  String? name;
  String? description;
  String? imgUrl;
  final DateTime addedDate;
  DateTime? expireDate;
  final bool hidden;
  final bool deleted;

  FoodItem({
    required this.id,
    this.name,
    this.description,
    this.imgUrl,
    required this.addedDate,
    this.expireDate,
    this.hidden = false,
    this.deleted = false,
  });
}
