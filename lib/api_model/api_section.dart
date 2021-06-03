import 'package:json_annotation/json_annotation.dart';
import 'package:wireless_order_system/api_model/api_child_dish.dart';
import 'package:wireless_order_system/api_model/api_dish.dart';

part 'api_section.g.dart';

@JsonSerializable()
class ApiSection{
  int id;
  String name;
  String imageUri;
  int restaurantId;
  List<ApiDish> dishes;

  ApiSection({
    required this.id,
    required this.name,
    required this.imageUri,
    required this.restaurantId,
    required this.dishes
  });

  factory ApiSection.fromJson(Map<String, dynamic> json) => _$ApiSectionFromJson(json);

  Map<String, dynamic> toJson() => _$ApiSectionToJson(this);
}