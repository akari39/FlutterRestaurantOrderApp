import 'package:json_annotation/json_annotation.dart';

part 'api_service.g.dart';

@JsonSerializable()
class ApiService{
  int id;
  String name;
  int restaurantId;

  ApiService({
    required this.id,
    required this.name,
    required this.restaurantId
  });

  factory ApiService.fromJson(Map<String, dynamic> json) => _$ApiServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ApiServiceToJson(this);
}