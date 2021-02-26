abstract class DishInfo {
  String id;
  String name;
  String stock;
  String price;

  bool operator <(Dish dish);
}

class ChildDish extends DishInfo with Comparable{
  String parentId;
  String parentName;
  String id;
  String name;
  String price;
  String stock;

  @override operator ==(Object object) => object is ChildDish && int.parse(object.id) == int.parse(id);

  @override
  int get hashCode => int.parse(id);
  
  ChildDish({this.id,this.name, this.price, this.stock,this.parentId,this.parentName}){
    super.id = id;
    super.stock = stock;
    super.name = name;
    super.price = price;
  }

  @override
  bool operator <(Dish dish) => int.parse(dish.id) > int.parse(this.id);

  bool operator >(Dish dish) => int.parse(dish.id) > int.parse(this.id);

  @override
  int compareTo(other) {
    if(other>this) return -1;
    else if(other<this) return 1;
    else return 0;
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
    super.id = id;
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
            parentName: "测试菜品",
            name: "测试类型1",
            price: "10.00",
            stock: "10"
          ),
          ChildDish(
              id: "202",
              parentId: "1",
              parentName: "测试菜品",
              name: "测试类型2",
              price: "8.00",
              stock: "10"
          ),
          ChildDish(
              id: "203",
              parentId: "1",
              parentName: "测试菜品",
              name: "测试类型2",
              price: "8.00",
              stock: "10"
          ),
          ChildDish(
              id: "204",
              parentId: "1",
              parentName: "测试菜品",
              name: "测试类型2",
              price: "8.00",
              stock: "10"
          ),
          ChildDish(
              id: "205",
              parentId: "1",
              parentName: "测试菜品",
              name: "测试类型2",
              price: "8.00",
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

  @override
  bool operator <(Dish dish) => int.parse(dish.id) > int.parse(this.id);

}

class Choice {
  Dish dish;
  ChildDish childDish;
  int count = 0;
  double price;

  get dishOfChoice => dish != null ? dish : childDish;

  Choice({this.dish, this.childDish, this.count, this.price});

  static clone(Choice choice) => Choice(dish:choice.dish, childDish: choice.childDish, count: choice.count, price: choice.price);

  static bool isChosenInStock<T extends DishInfo>(List<Choice> chosenList, T dish) =>
      chosenList.where((element) => element.dish != null ? element.dish == dish : element.childDish == dish).toList()[0].count < int.parse(dish.stock);

  static bool isInChosenList<T extends DishInfo>(List<Choice> chosenList, T dish) =>
      chosenList.where((element) => element.dish != null ? element.dish == dish : element.childDish == dish).toList().isNotEmpty;

  static List<Choice> getChoices<T extends DishInfo>(List<Choice> chosenList, Dish dish) {
    try{
      return chosenList.where((element) => dish.cpType == Dish.singleType ? element.dish == dish : dish.childTypes.contains(element.childDish)).toList();
    } catch (e){
      return null;
    }
  }

  static Choice getSingleChoice<T extends DishInfo>(List<Choice> chosenList, T dish) {
    return chosenList.where((element) => element.dish != null ? element.dish == dish : element.childDish == dish).toList().isNotEmpty ?
    chosenList.where((element) => element.dish != null ? element.dish == dish : element.childDish == dish).toList()[0] : null;
  }
}