import 'package:json_annotation/json_annotation.dart';

import 'api_choice.dart';

part 'api_order.g.dart';

@JsonSerializable()
class ApiOrder{
  double totalPrice;
  int restaurantServiceId;
  int restaurantDeskId;
  int restaurantId;
  List<ApiChoice> choiceList;
  int peopleAmount;

  ApiOrder({
    required this.totalPrice,
    required this.restaurantServiceId,
    required this.restaurantDeskId,
    required this.restaurantId,
    required this.choiceList,
    required this.peopleAmount
  });

  factory ApiOrder.fromJson(Map<String, dynamic> json) => _$ApiOrderFromJson(json);

  Map<String, dynamic> toJson() => _$ApiOrderToJson(this);
}