import 'package:json_annotation/json_annotation.dart';
import 'package:wireless_order_system/api_model/api_section.dart';
import 'package:wireless_order_system/api_model/api_service.dart';
import 'package:wireless_order_system/wos_network.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant {
  String? id;
  String? name;
  String? subName;
  String? restaurantImage;
  List<ApiSection>? dishTypes;
  List<ApiService>? services;

  static int? deskId;
  static Restaurant? _testInstance;
  static Restaurant _restaurant = new Restaurant();

  Restaurant({this.id, this.name, this.subName, this.restaurantImage, this.dishTypes, this.services});

  factory Restaurant.fromJson(Map<String, dynamic> json) => _$RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
  
  static void initRestaurant(Map<String, dynamic> data) {
    _restaurant = Restaurant.fromJson(data);
  }
  
  static Restaurant get instance {
    return _restaurant;
  }

  bool isEmpty() {
    return id == null;
  }

  // static Restaurant? sample() {
  //   _testInstance = Restaurant(id: "1",
  //       name: "测试店名测试店名测试店名",
  //       subName: "松江店",
  //       restaurantImage: "https://s1.hdslb.com/bfs/static/jinkela/popular/assets/icon_popular.png",
  //       dishTypes: {"测试品类1": "https://s1.hdslb.com/bfs/static/jinkela/popular/assets/icon_popular.png",
  //         "测试品类2": "https://s1.hdslb.com/bfs/static/jinkela/popular/assets/icon_popular.png",
  //       },
  //       services: ["倒茶","换盘","招呼服务员"]
  //   );
  //   return _testInstance;
  // }
}