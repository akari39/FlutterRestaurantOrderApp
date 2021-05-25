// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiOrder _$ApiOrderFromJson(Map<String, dynamic> json) {
  return ApiOrder(
    totalPrice: (json['totalPrice'] as num).toDouble(),
    restaurantServiceId: json['restaurantServiceId'] as int,
    restaurantDeskId: json['restaurantDeskId'] as int,
    restaurantId: json['restaurantId'] as int,
    choiceList: (json['choiceList'] as List<dynamic>)
        .map((e) => ApiChoice.fromJson(e as Map<String, dynamic>))
        .toList(),
    peopleAmount: json['peopleAmount'] as int,
  );
}

Map<String, dynamic> _$ApiOrderToJson(ApiOrder instance) => <String, dynamic>{
      'totalPrice': instance.totalPrice,
      'restaurantServiceId': instance.restaurantServiceId,
      'restaurantDeskId': instance.restaurantDeskId,
      'restaurantId': instance.restaurantId,
      'choiceList': instance.choiceList,
      'peopleAmount': instance.peopleAmount,
    };
