import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';

part 'dish.g.dart';

abstract class DishInfo {
  int? id;
  String? name;
  int? stock;
  double? price;

  bool operator <(Dish dish);
}

@JsonSerializable()
class ChildDish extends DishInfo with Comparable{
  int? parentId;
  String? parentName;

  @override operator ==(Object object) => object is ChildDish && object.id == id;

  @override
  int get hashCode => id!;
  
  ChildDish({int? id, String? name, double? price, int? stock, this.parentId, this.parentName}) {
    super.id = id;
    super.stock = stock;
    super.name = name;
    super.price = price;
  }

  factory ChildDish.fromJson(Map<String, dynamic> json) => _$ChildDishFromJson(json);

  Map<String, dynamic> toJson() => _$ChildDishToJson(this);

  @override
  String toString() {
    return 'ChildDish{id: $id, name: $name, stock: $stock, price: $price, parentId: $parentId, parentName: $parentName}';
  }

  @override
  bool operator <(Dish dish) => dish.id! > this.id!;

  bool operator >(Dish dish) => dish.id! > this.id!;

  @override
  int compareTo(other) {
    if(other>this) return -1;
    else if(other<this) return 1;
    else return 0;
  }

}

@JsonSerializable()
class Dish extends DishInfo{
  String? image;
  String? description;
  String? dishTypes;
  List<ChildDish>? childTypes;

  static const int intPrice = 0;
  static const int decimalPrice = 1;

  static const int multiType = 2;
  static const int singleType = 3;

  Dish({int? id, this.image, String? name, this.description, this.dishTypes, double? price, int? stock, this.childTypes}){
    super.id = id;
    super.stock = stock;
    super.name = name;
    super.price = price;
  }

  @override
  int get hashCode => id!;

  int get cpType => childTypes == null || childTypes!.isEmpty ? singleType : multiType;

  bool operator ==(Object other) {
    return other is Dish && other.id == id;
  }

  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);

  Map<String, dynamic> toJson() => _$DishToJson(this);

  @override
  String toString() {
    return 'Dish{id: $id, image: $image, name: $name, description: $description, dishTypes: $dishTypes, price: $price, stock: $stock, childTypes: $childTypes, childTypesIsEmpty: ${childTypes?.isEmpty}, cpType: $cpType}';
  }

  static Dish sample() {
    return Dish(
        id: 1,
        image: "https://i0.hdslb.com/bfs/bangumi/image/dda6999ee8867f8496f914461f4d175a664429fe.png@140w_140h_1c_100q.webp",
        name: "测试菜品",
        description: "描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述",
        dishTypes: "测试品类1",
        price: 0.0,
        stock: 0,
        childTypes: [
          ChildDish(
            id: 201,
            parentId: 1,
            parentName: "测试菜品",
            name: "测试类型1",
            price: 10.00,
            stock: 10
          ),
          ChildDish(
              id: 202,
              parentId: 1,
              parentName: "测试菜品",
              name: "测试类型2",
              price: 8.00,
              stock: 10
          ),
          ChildDish(
              id: 203,
              parentId: 1,
              parentName: "测试菜品",
              name: "测试类型2",
              price: 8.00,
              stock: 10
          ),
          ChildDish(
              id: 204,
              parentId: 1,
              parentName: "测试菜品",
              name: "测试类型2",
              price: 8.00,
              stock: 10
          ),
          ChildDish(
              id: 205,
              parentId: 1,
              parentName: "测试菜品",
              name: "测试类型2",
              price: 8.00,
              stock: 10
          )
        ],
    );
  }

  static Dish sample2() {
    return Dish(
        id: 2,
        image: "https://i0.hdslb.com/bfs/bangumi/image/dda6999ee8867f8496f914461f4d175a664429fe.png@140w_140h_1c_100q.webp",
        name: "测试菜品",
        description: "描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述",
        dishTypes: "测试品类2",
        price: 1.00,
        stock: 10
    );
  }

  String getPriceString(int type) =>
    (cpType == Dish.singleType ? this.price : (this.childTypes!.reduce((value,
        element) =>
    value.price! < element.price!
        ? value
        : element)).price)!.toStringAsFixed(2).split(".")[type];

  int? getChildDishesMaxStock() {
    assert(childTypes != null);
    return this.childTypes!.fold(0, (previousValue, element) =>
    previousValue! > element.stock! ? previousValue : element.stock);
  }

  @override
  bool operator <(Dish dish) => dish.id! > this.id!;
}

class Choice {
  Dish? dish;
  ChildDish? childDish;
  int? count = 0;
  double? price;

  DishInfo get dishOfChoice => dish != null ? dish! : childDish!;

  set dishOfChoice(DishInfo dish) {
    if(dish is Dish) {
      this.dish = dish;
    } else {
      childDish = dish as ChildDish?;
    }
  }

  Choice({this.dish, this.childDish, this.count, this.price});

  static clone(Choice choice) => Choice(dish:choice.dish, childDish: choice.childDish, count: choice.count, price: choice.price);

  static bool isChosenInStock<T extends DishInfo>(List<Choice> chosenList, T dish) =>
      chosenList.where((element) => element.dish != null ? element.dish == dish : element.childDish == dish).toList()[0].count! < dish.stock!;

  static bool isInChosenList<T extends DishInfo>(List<Choice> chosenList, T dish) =>
      chosenList.where((element) => element.dish != null ? element.dish == dish : element.childDish == dish).toList().isNotEmpty;

  static List<Choice>? getChoices<T extends DishInfo>(List<Choice> chosenList, Dish dish) {
    try{
      return chosenList.where((element) => dish.cpType == Dish.singleType ? element.dish == dish : dish.childTypes!.contains(element.childDish)).toList();
    } catch (e){
      return null;
    }
  }

  static Choice? getSingleChoice<T extends DishInfo>(List<Choice> chosenList, T dish) {
    return chosenList.where((element) => element.dish != null ? element.dish == dish : element.childDish == dish).toList().isNotEmpty ?
    chosenList.where((element) => element.dish != null ? element.dish == dish : element.childDish == dish).toList()[0] : null;
  }

  @override
  toString(){
    if(dish != null) return "{${dish!.name},$count,$price}";
    else return "{${childDish!.name},$count,$price}";
  }


}