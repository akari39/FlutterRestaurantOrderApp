class Restaurant {
  String id;
  String name;
  String parentRestaurantId;
  String subName;
  String restaurantImage;
  static Restaurant _testInstance;

  Restaurant(this.id, this.name, this.parentRestaurantId, this.subName, this.restaurantImage);

  static Restaurant sample() {
    _testInstance = Restaurant("1",
        "测试店名测试店名测试店名",
        "18",
        "松江店",
        "https://www.apple.com.cn/home/heroes/cny-2021-film-bts/images/cny__gaectlu0tiai_large_2x.jpg");
    return _testInstance;
  }
}