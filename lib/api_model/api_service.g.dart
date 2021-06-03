// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiService _$ApiServiceFromJson(Map<String, dynamic> json) {
  return ApiService(
    id: json['id'] as int,
    name: json['name'] as String,
    restaurantId: json['restaurantId'] as int,
  );
}

Map<String, dynamic> _$ApiServiceToJson(ApiService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'restaurantId': instance.restaurantId,
    };
