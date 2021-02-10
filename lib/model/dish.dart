class Dish {
  String id;
  String image;
  String name;
  String describtion;
  List<String> dishTypes;

  Dish(this.id, this.image, this.name, this.describtion,this.dishTypes);

  Dish.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.image = json['image'];
    this.name = json['name'];
    this.describtion = json['describtion'];
    this.dishTypes = json['dishTypes'];
  }
}