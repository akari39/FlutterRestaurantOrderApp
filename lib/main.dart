import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wireless_order_system/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if(Theme.of(context).platform == TargetPlatform.android) {
      SystemUiOverlayStyle _style = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark
      );
      SystemChrome.setSystemUIOverlayStyle(_style);
    }

    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xffE3A20E),
        accentColor: Color(0xff222222),
        buttonTheme: ButtonThemeData(
          buttonColor: Theme.of(context).primaryColor,
          textTheme: ButtonTextTheme.primary
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: Color(0xffE3A20E))
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(primary: Color(0xffE3A20E))
        ),
        textTheme: TextTheme(
          headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color(0xff222222)),
        ),
      ),
      home: Home(),
    );
  }
}