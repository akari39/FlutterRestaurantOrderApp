// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestChoice _$RequestChoiceFromJson(Map<String, dynamic> json) {
  return RequestChoice(
    json['dish'] == null
        ? null
        : Dish.fromJson(json['dish'] as Map<String, dynamic>),
    json['childDish'] == null
        ? null
        : ChildDish.fromJson(json['childDish'] as Map<String, dynamic>),
    json['count'] as int?,
    (json['totalPrice'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$RequestChoiceToJson(RequestChoice instance) =>
    <String, dynamic>{
      'dish': instance.dish,
      'childDish': instance.childDish,
      'count': instance.count,
      'totalPrice': instance.totalPrice,
    };
