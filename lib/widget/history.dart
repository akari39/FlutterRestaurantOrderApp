import 'package:flutter/material.dart';
import 'package:wireless_order_system/widget/home.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FullAppbar(
        title: "历史订单",
        hasParent: true,
        onBackPressed: () => Navigator.of(context).pop()
      ),
      body: SingleChildScrollView(

      )
    );
  }

}