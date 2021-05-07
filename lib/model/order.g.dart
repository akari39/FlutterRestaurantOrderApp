// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestChoice _$RequestChoiceFromJson(Map<String, dynamic> json) {
  return RequestChoice(
    json['name'] as String?,
    json['childType'] as String?,
    json['count'] as int?,
    (json['price'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$RequestChoiceToJson(RequestChoice instance) =>
    <String, dynamic>{
      'name': instance.name,
      'childType': instance.childType,
      'count': instance.count,
      'price': instance.price,
    };
