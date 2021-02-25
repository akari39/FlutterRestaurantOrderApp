import 'dart:core';

import 'dish.dart';

class Order {
  String id;
  String createdTime;
  String status;
  Map<Dish,Map<String,String>> dishes;

  Order.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.createdTime = json['id'];
    this.status = json['status'];
    this.dishes = json['dishes'];
  }
}