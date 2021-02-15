class Dish {
  String id;
  String image;
  String name;
  String description;
  String dishTypes;
  static Dish _testInstance;

  Dish({this.id, this.image, this.name, this.description,this.dishTypes});

  Dish.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.image = json['image'];
    this.name = json['name'];
    this.description = json['description'];
    this.dishTypes = json['dishTypes'];
  }

  static Dish sample() {
    _testInstance = Dish(
        id: "1",
        image:  "https://s1.hdslb.com/bfs/static/jinkela/popular/assets/icon_popular.png",
        name: "测试菜品",
        description: "描述",
        dishTypes: "测试品类");
    return _testInstance;
  }
}