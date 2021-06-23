// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiSection _$ApiSectionFromJson(Map<String, dynamic> json) {
  return ApiSection(
    id: json['id'] as int,
    name: json['name'] as String,
    imageUri: json['imageUri'] as String,
    restaurantId: json['restaurantId'] as int,
    dishes: (json['dishes'] as List<dynamic>?)
        ?.map((e) => ApiDish.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ApiSectionToJson(ApiSection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUri': instance.imageUri,
      'restaurantId': instance.restaurantId,
      'dishes': instance.dishes,
    };
