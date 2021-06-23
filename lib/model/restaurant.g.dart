// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) {
  return Restaurant(
    id: json['id'] as int?,
    name: json['name'] as String?,
    subName: json['subName'] as String?,
    restaurantImage: json['restaurantImage'] as String?,
    dishTypes: (json['dishTypes'] as List<dynamic>?)
        ?.map((e) => ApiSection.fromJson(e as Map<String, dynamic>))
        .toList(),
    services: (json['services'] as List<dynamic>?)
        ?.map((e) => ApiService.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subName': instance.subName,
      'restaurantImage': instance.restaurantImage,
      'dishTypes': instance.dishTypes,
      'services': instance.services,
    };
