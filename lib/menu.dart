import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wireless_order_system/model/restaurant.dart';
import 'package:wireless_order_system/start.dart';

class _MenuBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuBodyState();

}

class _MenuBodyState extends State<_MenuBody> {
  @override
  Widget build(BuildContext context) {
    return Column(

    );
  }

}

class Menu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuState();
}

class _MenuState extends State<Menu>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailAppBar(
        restaurantName: Restaurant.sample().name,
        restaurantImage: Restaurant.sample().restaurantImage,
        restaurantSubName: Restaurant.sample().subName,
        desk: "A10"
      ),
    );
  }
}