import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wireless_order_system/model/dish.dart';
import 'package:wireless_order_system/model/restaurant.dart';
import 'package:wireless_order_system/wos_network.dart';
import 'package:wireless_order_system/widget/home.dart';
import 'package:wireless_order_system/widget/order_detail.dart';

import 'menu.dart';

class OrderList extends StatelessWidget {
  final List<Choice>? choices;
  final List<Dish>? dishes;
  final String? totalPrice;

  OrderList({this.choices, this.dishes, this.totalPrice});

  @override
  Widget build(BuildContext context) {
    log(choices.toString());
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(width: 1.0, color: Colors.black12)
        ),
        elevation: 0,
        child: Column(
            children: [
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: choices!.length,
                itemBuilder: (context,index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              width: 80,
                              height: 80,
                              imageUrl: choices![index].dish != null ? choices![index].dish!.image! :
                              dishes!.where((element) =>
                              element.childTypes != null ? element.childTypes!.contains(choices![index].childDish) : false).toList()[0].image!,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error_outline)
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(choices![index].childDish == null ? choices![index].dish!.name! : choices![index].childDish!.parentName!,
                                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                    ),
                                    if(choices![index].childDish != null)
                                      Text(choices![index].childDish!.name!,
                                      style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor))
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "¥${choices![index].price!.toStringAsFixed(2).split(".")[0]}.",
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)
                                          ),
                                          TextSpan(
                                            text: "${choices![index].price!.toStringAsFixed(2).split(".")[1]}",
                                            style: TextStyle(fontSize: 17, color: Theme.of(context).accentColor)
                                          )
                                        ]
                                      )
                                    ),
                                    Text("¥${choices![index].dish != null ?
                                    choices![index].dish!.price : choices![index].childDish!.price}",
                                        style: TextStyle(fontSize: 14, color: Theme.of(context).accentColor)),
                                    Text("${choices![index].count}份",style: TextStyle(fontSize: 14, color: Theme.of(context).accentColor))
                                  ]
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      if(index != choices!.length-1) Divider()
                    ],
                  );
                }),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("总计"),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "¥${totalPrice!.split(".")[0]}.",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)
                            ),
                            TextSpan(
                              text: "${totalPrice!.split(".")[1]}",
                              style: TextStyle(fontSize: 17, color: Theme.of(context).accentColor)
                            )
                          ]
                        )
                      ),
                    ),
                  ],
                ),
              )
            ]
          ),
        )
    );
  }
}

class ConfirmOrder extends StatefulWidget {
  final List<Choice>? choices;
  final List<Dish>? dishes;
  final String? totalPrice;

  final Function? addBackCart;

  ConfirmOrder({this.choices, this.dishes, this.totalPrice, this.addBackCart});

  @override
  State<StatefulWidget> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {

  submitOrder() async {

  }

  bool inConfirmPage = true;

  @override
  void initState() {
    super.initState();
    inConfirmPage = true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
          if(inConfirmPage) { widget.addBackCart!(); return true;}
          else return false;
        },
      child: Scaffold(
        extendBody: true,
        appBar: FullAppbar(
          title: "确认订单",
          hasParent: true,
          onBackPressed: () {
            Navigator.of(context).pop();
            widget.addBackCart!();
          },
        ),
        body: Column(
          children: [
            Services(
                availableServices: Restaurant.sample()!.services
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text("请确认您的点单", style: Theme.of(context).textTheme.headline6)
                      ),
                    ),
                    OrderList(
                      choices: widget.choices,
                      dishes: widget.dishes,
                      totalPrice: widget.totalPrice,
                    ),
                    Container(height: 80)
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: Color(0xffF2F2F2),
                    child: Container(height: 44, width: MediaQuery.of(context).size.width-32,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0, bottom: 10.0),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width-32
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                            child: Text("总计")
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "¥${widget.totalPrice!.split(".")[0]}.",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)
                                  ),
                                  TextSpan(
                                    text: "${widget.totalPrice!.split(".")[1]}",
                                    style: TextStyle(fontSize: 17, color: Theme.of(context).accentColor)
                                  )
                                ]
                              )
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await submitOrder();
                              inConfirmPage = false;
                              Navigator.pushAndRemoveUntil(
                                  this.context,
                                  MaterialPageRoute(
                                  builder: (context) {
                                    return OrderDetail(
                                        totalPrice: widget.totalPrice,
                                        choices: widget.choices,
                                        dishes: widget.dishes
                                      );
                                    }
                                  ),
                                  (check) => false
                              );
                            },
                            child: Text("提交")
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}