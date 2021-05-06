import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  String id;
  String name;
  String email;
  String token;

  User(this.id, this.name, this.email);

  User.withToken(this.id, this.name, this.email,this.token);



}