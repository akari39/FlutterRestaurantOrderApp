// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChildDish _$ChildDishFromJson(Map<String, dynamic> json) {
  return ChildDish(
    id: json['id'] as int?,
    name: json['name'] as String?,
    price: (json['price'] as num?)?.toDouble(),
    stock: json['stock'] as int?,
    parentId: (json['parentId'] as num?)?.toDouble(),
    parentName: json['parentName'] as String?,
  );
}

Map<String, dynamic> _$ChildDishToJson(ChildDish instance) => <String, dynamic>{
      'parentId': instance.parentId,
      'parentName': instance.parentName,
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'stock': instance.stock,
    };

Dish _$DishFromJson(Map<String, dynamic> json) {
  return Dish(
    id: json['id'] as int?,
    image: json['image'] as String?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    dishTypes: json['dishTypes'] as String?,
    price: (json['price'] as num?)?.toDouble(),
    stock: json['stock'] as int?,
    childTypes: (json['childTypes'] as List<dynamic>?)
        ?.map((e) => ChildDish.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DishToJson(Dish instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'description': instance.description,
      'dishTypes': instance.dishTypes,
      'price': instance.price,
      'stock': instance.stock,
      'childTypes': instance.childTypes,
    };
