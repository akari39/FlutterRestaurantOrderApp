import 'package:json_annotation/json_annotation.dart';

part 'api_child_dish.g.dart';

@JsonSerializable()
class ApiChildDish {
  int id;
  String name;
  int parentId;
  double price;
  int stock;

  ApiChildDish({
    required this.id,
    required this.name,
    required this.parentId,
    required this.price,
    required this.stock
  });

  factory ApiChildDish.fromJson(Map<String, dynamic> json) => _$ApiChildDishFromJson(json);

  Map<String, dynamic> toJson() => _$ApiChildDishToJson(this);
}