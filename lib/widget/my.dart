import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wireless_order_system/widget/start.dart';

import 'home.dart';

class MyPage extends StatelessWidget {
  final String myUserName;

  MyPage({required this.myUserName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailAppBar(
        onPressUser: () {Navigator.of(context).pop(); },
      ),
      body: Column(
        children: [
          Center(child: Text("欢迎您，$myUserName", style: Theme.of(context).textTheme.headline6)),
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Container(
                height: 44,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  child: InkWell(
                    child: Text("查看历史订单"),
                    onTap: (){},
                  ),
                ),
              ),
              Container(
                height: 44,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  child: InkWell(
                    child: Text("注销"),
                    onTap: () {
                      //TODO: delete user info
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()), (route) => true);
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

}