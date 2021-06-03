// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiRestaurant _$ApiRestaurantFromJson(Map<String, dynamic> json) {
  return ApiRestaurant(
    id: json['id'] as int,
    restaurantName: json['restaurantName'] as String,
    subName: json['subName'] as String,
    restaurantLogoUri: json['restaurantLogoUri'] as String,
    managerId: json['managerId'] as int,
  );
}

Map<String, dynamic> _$ApiRestaurantToJson(ApiRestaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'restaurantName': instance.restaurantName,
      'subName': instance.subName,
      'restaurantLogoUri': instance.restaurantLogoUri,
      'managerId': instance.managerId,
    };
