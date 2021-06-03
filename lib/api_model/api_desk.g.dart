// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_desk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiDesk _$ApiDeskFromJson(Map<String, dynamic> json) {
  return ApiDesk(
    id: json['id'] as int,
    type: json['type'] as int,
    number: json['number'] as int,
    restaurantId: json['restaurantId'] as int,
    seatAmount: json['seatAmount'] as int,
    peopleAmount: json['peopleAmount'] as int?,
  );
}

Map<String, dynamic> _$ApiDeskToJson(ApiDesk instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'number': instance.number,
      'restaurantId': instance.restaurantId,
      'seatAmount': instance.seatAmount,
      'peopleAmount': instance.peopleAmount,
    };
