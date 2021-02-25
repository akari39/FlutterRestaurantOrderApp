abstract class DishInfo {
  String name;
  String stock;
  String price;
}

class ChildDish extends DishInfo {
  String parentId;
  String id;
  String name;
  String price;
  String stock;

  ChildDish({this.id,this.name, this.price, this.stock,this.parentId}){
    super.stock = stock;
    super.name = name;
    super.price = price;
  }
}

class Dish extends DishInfo{
  String id;
  String image;
  String name;
  String description;
  String dishTypes;
  String price;
  String stock;
  List<ChildDish> childTypes;
  static Dish _testInstance;

  static const int intPrice = 0;
  static const int decimalPrice = 1;

  static const int multiType = 2;
  static const int singleType = 3;

  Dish({this.id, this.image, this.name, this.description,this.dishTypes, this.price, this.stock, this.childTypes}){
    super.stock = stock;
    super.name = name;
    super.price = price;
  }

  @override
  int get hashCode => int.parse(id);

  int get cpType => childTypes == null ? singleType : multiType;

  bool operator ==(Object other) {
    return other is Dish && int.parse(other.id) == int.parse(id);
  }

  Dish.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.image = json['image'];
    this.name = json['name'];
    this.description = json['description'];
    this.dishTypes = json['dishTypes'];
    this.childTypes = json['childTypes'];
    this.price = json['price'];
    this.stock = json['stock'];
  }

  static Dish sample() {
    _testInstance = Dish(
        id: "1",
        image: "https://i0.hdslb.com/bfs/bangumi/image/dda6999ee8867f8496f914461f4d175a664429fe.png@140w_140h_1c_100q.webp",
        name: "测试菜品",
        description: "描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述",
        dishTypes: "测试品类1",
        childTypes: [
          ChildDish(
            id: "201",
            parentId: "1",
            name: "测试类型",
            price: "1.00",
            stock: "10"
          )
        ],
    );
    return _testInstance;
  }

  static Dish sample2() {
    return Dish(
        id: "2",
        image: "https://i0.hdslb.com/bfs/bangumi/image/dda6999ee8867f8496f914461f4d175a664429fe.png@140w_140h_1c_100q.webp",
        name: "测试菜品",
        description: "描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述",
        dishTypes: "测试品类2",
        price: "1.00",
        stock: "10"
    );
  }

  String getPriceString(int type) =>
    (cpType == Dish.singleType ? this.price : (this.childTypes.reduce((value,
        element) =>
    double.parse(value.price) < double.parse(element.price)
        ? value
        : element)).price).split(".")[type];

  int getChildDishesMaxStock() {
    assert(childTypes != null);
    return this.childTypes.fold(0, (previousValue, element) =>
    previousValue > int.parse(element.stock) ? previousValue : int.parse(element.stock));
  }

}

class Choice {
  Dish dish;
  ChildDish childDish;
  int count = 0;
  double price;

  Choice({this.dish, this.childDish, this.count, this.price});

  bool operator ==(Object object) => object is Choice && object.dish == dish;

  @override
  int get hashCode {
    return childDish == null ? int.parse(dish.id) : int.parse(childDish.id);
  }

  static bool isChosenInStock<T extends DishInfo>(List<Choice> chosenList, T dish) =>
      chosenList.where((element) => element.dish != null ? element.dish == dish : element.childDish == dish).toList()[0].count < int.parse(dish.stock);

  static bool isInChosenList<T extends DishInfo>(List<Choice> chosenList, T dish) =>
      chosenList.where((element) => element.dish != null ? element.dish == dish : element.childDish == dish).toList().isNotEmpty;

  static Choice getSingleChoice<T extends DishInfo>(List<Choice> chosenList, T dish) {
    return chosenList.where((element) => element.dish != null ? element.dish == dish : element.childDish == dish).toList().isNotEmpty ?
    chosenList.where((element) => element.dish != null ? element.dish == dish : element.childDish == dish).toList()[0] : null;
  }

}