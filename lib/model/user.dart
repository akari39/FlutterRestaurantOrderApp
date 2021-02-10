import 'dart:core';

class User {
  String id;
  String name;
  String email;
  String token;
  List<String> preference = [];

  User(this.id, this.name, this.email);

  User.withToken(this.id, this.name, this.email,this.token);

  User.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.email = json['email'];
    this.token = json['token'];
  }
}