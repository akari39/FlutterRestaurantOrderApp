import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wireless_order_system/widget/start.dart';

import 'home.dart';

class MyPage extends StatelessWidget {
  final String myUserName;
  final BuildContext context;

  MyPage(this.context, {required this.myUserName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailAppBar(
        onPressUser: () {Navigator.of(context).pop(); },
      ),
      body: Column(
        children: [
          Center(child: Text("欢迎您，$myUserName", style: Theme.of(context).textTheme.headline6)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Container(
                  height: 50,
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Row(
                        children: [
                          Icon(Icons.history_outlined),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("查看历史订单", style: TextStyle(fontSize: 17.0)),
                          ),
                        ],
                      )
                    ),
                    onTap: (){},
                  ),
                ),
                Container(
                  height: 50,
                  child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Row(
                          children: [
                            Icon(Icons.exit_to_app_outlined),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text("注销", style: TextStyle(fontSize: 17.0)),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        //TODO: delete user info
                        Navigator.of(this.context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Home()), (route) => false);
                      },
                    ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}