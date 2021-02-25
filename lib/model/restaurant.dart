class Restaurant {
  String id;
  String name;
  String parentRestaurantId;
  String subName;
  String restaurantImage;
  Map<String,String> dishTypes;
  List<String> services;
  static Restaurant _testInstance;

  Restaurant({this.id, this.name, this.parentRestaurantId, this.subName, this.restaurantImage, this.dishTypes, this.services});

  static Restaurant sample() {
    _testInstance = Restaurant(id: "1",
        name: "测试店名测试店名测试店名",
        parentRestaurantId: "18",
        subName: "松江店",
        restaurantImage: "https://s1.hdslb.com/bfs/static/jinkela/popular/assets/icon_popular.png",
        dishTypes: {"测试品类1": "https://s1.hdslb.com/bfs/static/jinkela/popular/assets/icon_popular.png",
          "测试品类2": "https://s1.hdslb.com/bfs/static/jinkela/popular/assets/icon_popular.png",
        },
        services: ["倒茶","换盘","招呼服务员"]
    );
    return _testInstance;
  }
}