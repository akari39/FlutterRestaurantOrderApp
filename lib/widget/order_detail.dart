import 'package:flutter/material.dart';
import 'package:wireless_order_system/model/dish.dart';
import 'package:wireless_order_system/model/order.dart';
import 'package:wireless_order_system/model/restaurant.dart';
import 'package:wireless_order_system/widget/confirm_order.dart';
import 'package:wireless_order_system/widget/start.dart';

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
          restaurantName: Restaurant.sample()!.name,
          restaurantSubName: Restaurant.sample()!.subName,
          restaurantImage: Restaurant.sample()!.restaurantImage,
          desk: "A10"
        ),
        body: Column(
          children: [
            Services(
              availableServices: Restaurant.sample()!.services
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
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) {
                                  return Menu();
                                }
                              )
                            );
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