import 'package:json_annotation/json_annotation.dart';

part 'api_restaurant.g.dart';

@JsonSerializable()
class ApiRestaurant {
  int id;
  String restaurantName;
  String subName;
  String restaurantLogoUri;
  int managerId;

  ApiRestaurant({
    required this.id,
    required this.restaurantName,
    required this.subName,
    required this.restaurantLogoUri,
    required this.managerId
  });

  factory ApiRestaurant.fromJson(Map<String, dynamic> json) => _$ApiRestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$ApiRestaurantToJson(this);
}