// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_choice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiChoice _$ApiChoiceFromJson(Map<String, dynamic> json) {
  return ApiChoice(
    dishId: json['dishId'] as int,
    childDishId: json['childDishId'] as int?,
    price: (json['price'] as num).toDouble(),
    count: json['count'] as int,
  );
}

Map<String, dynamic> _$ApiChoiceToJson(ApiChoice instance) => <String, dynamic>{
      'dishId': instance.dishId,
      'childDishId': instance.childDishId,
      'price': instance.price,
      'count': instance.count,
    };
