// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_child_dish.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiChildDish _$ApiChildDishFromJson(Map<String, dynamic> json) {
  return ApiChildDish(
    id: json['id'] as int,
    name: json['name'] as String,
    parentId: json['parentId'] as int,
    price: (json['price'] as num).toDouble(),
    stock: json['stock'] as int,
  );
}

Map<String, dynamic> _$ApiChildDishToJson(ApiChildDish instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parentId': instance.parentId,
      'price': instance.price,
      'stock': instance.stock,
    };
