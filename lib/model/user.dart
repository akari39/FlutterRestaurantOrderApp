import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  String name;
  String email;
  String? token;

  User(this.id, this.name, this.email);

  User.withToken(this.id, this.name, this.email,this.token);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}