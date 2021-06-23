import 'package:flutter/material.dart';
import 'package:wireless_order_system/model/dish.dart';
import 'package:wireless_order_system/model/restaurant.dart';
import 'package:wireless_order_system/widget/confirm_order.dart';
import 'package:wireless_order_system/widget/start.dart';

import '../wos_network.dart';
import 'menu.dart';

class OrderDetail extends StatefulWidget {
  final List<Choice>? choices;
  final List<Dish>? dishes;
  final String? totalPrice;

  const OrderDetail({Key? key, this.totalPrice, this.choices, this.dishes}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail>{
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async { return true; },
      child: Scaffold(
        appBar: DetailAppBar(
          restaurantName: Restaurant.instance.name,
          restaurantSubName: Restaurant.instance.subName,
          restaurantImage: Restaurant.instance.restaurantImage,
          desk: Restaurant.deskId.toString()
        ),
        body: Column(
          children: [
            if(Restaurant.instance.services != null)
              if(Restaurant.instance.services!.isNotEmpty)
                Services(
                  availableServices: Restaurant.instance.services!.map((e) => e.name).toList()
                ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                  alignment: Alignment.center,
                  child: Text("下单成功！", style: Theme.of(context).textTheme.headline6)
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      OrderList(
                        choices: widget.choices,
                        dishes: widget.dishes,
                        totalPrice: widget.totalPrice
                      ),
                      ElevatedButton.icon(
                          onPressed: (){
                            WOSNetwork.instance.get(WOSNetwork.getMenu, {"childDeskId": Restaurant.deskId.toString()}, (data) {
                              List<Dish> dishes = [];
                              data.forEach((element) {
                                Dish dish = Dish.fromJson(element);
                                this.setState(() {
                                  dishes.add(dish);
                                });
                              });
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => Menu(dishes: dishes))
                              );
                            });
                          },
                          icon: Icon(Icons.menu_book_outlined),
                          label: Text("返回菜单")
                      ),
                      ElevatedButton.icon(
                          onPressed: (){
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => StartWidget(isRescan: true)), (route) => false);
                          },
                          icon: Icon(Icons.qr_code_outlined),
                          label: Text("重新扫码")
                      )
                    ],
                  ),
                )
            )
          ],
        )
      ),
    );
  }
}