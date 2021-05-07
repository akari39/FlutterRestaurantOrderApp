import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

import 'dish.dart';

part 'order.g.dart';

class Order {
  String? id;
  String? createdTime;
  String? desk;
  List<RequestChoice>? requestChoices;
}

@JsonSerializable()
class RequestChoice {
  final String? name;
  final String? childType;
  final int? count;
  final double? price;

  RequestChoice(this.name, this.childType, this.count, this.price);

  static fromChoice(Choice choice, List<Dish> dishes) {
    if(choice.dishOfChoice is Dish) return RequestChoice((choice.dishOfChoice as Dish).name,null,choice.count,choice.price);
    else {
      String? name;
      for(var dish in dishes) {
        if (dish.childTypes != null) {
          if(dish.childTypes!.contains(choice.childDish)) {
            name = dish.name;
            break;
          }
        }
      }
      return RequestChoice(
          name, (choice.dishOfChoice as ChildDish).name, choice.count,
          choice.price);
    }
  }
}