import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wireless_order_system/api_model/api_child_dish.dart';

part 'api_dish.g.dart';

@JsonSerializable()
class ApiDish {
  int id;
  String name;
  String description;
  String imageUri;
  int stock;
  double price;
  List<ApiChildDish> childDishes;

  ApiDish({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUri,
    required this.stock,
    required this.price,
    required this.childDishes
  });

  factory ApiDish.fromJson(Map<String, dynamic> json) => _$ApiDishFromJson(json);

  Map<String, dynamic> toJson() => _$ApiDishToJson(this);

}