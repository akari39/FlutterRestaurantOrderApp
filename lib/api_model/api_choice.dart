import 'package:json_annotation/json_annotation.dart';

part 'api_choice.g.dart';

@JsonSerializable()
class ApiChoice {
  int dishId;
  int? childDishId;
  double price;
  int count;

  ApiChoice({
    required this.dishId,
    this.childDishId,
    required this.price,
    required this.count
  });

  factory ApiChoice.fromJson(Map<String, dynamic> json) => _$ApiChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$ApiChoiceToJson(this);
}