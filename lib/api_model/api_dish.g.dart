// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_dish.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiDish _$ApiDishFromJson(Map<String, dynamic> json) {
  return ApiDish(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    imageUri: json['imageUri'] as String,
    stock: json['stock'] as int,
    price: (json['price'] as num).toDouble(),
    childDishes: (json['childDishes'] as List<dynamic>)
        .map((e) => ApiChildDish.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ApiDishToJson(ApiDish instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUri': instance.imageUri,
      'stock': instance.stock,
      'price': instance.price,
      'childDishes': instance.childDishes,
    };
