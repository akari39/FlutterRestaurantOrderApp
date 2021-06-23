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
  final Dish? dish;
  final ChildDish? childDish;
  final int? count;
  final double? totalPrice;

  RequestChoice(this.dish, this.childDish, this.count, this.totalPrice);

  static fromChoice(Choice choice, List<Dish> dishes) {
    if(choice.dishOfChoice is Dish) return RequestChoice((choice.dishOfChoice as Dish),new ChildDish(id: -1),choice.count,choice.price);
    else {
      Dish parentDish = new Dish();
      for(var dish in dishes) {
        if (dish.cpType == Dish.multiType) {
          if(dish.childTypes!.contains(choice.childDish)) {
            parentDish = dish;
            break;
          }
        }
      }
      return RequestChoice(
          parentDish, (choice.dishOfChoice as ChildDish), choice.count, choice.price
      );
    }
  }
}