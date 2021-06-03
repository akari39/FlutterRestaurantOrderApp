import 'package:json_annotation/json_annotation.dart';

part 'api_desk.g.dart';

@JsonSerializable()
class ApiDesk {
  int id;
  int type;
  int number;
  int restaurantId;
  int seatAmount;
  int? peopleAmount;

  ApiDesk({
    required this.id,
    required this.type,
    required this.number,
    required this.restaurantId,
    required this.seatAmount,
    required this.peopleAmount
  });

  factory ApiDesk.fromJson(Map<String, dynamic> json) => _$ApiDeskFromJson(json);

  Map<String, dynamic> toJson() => _$ApiDeskToJson(this);
}