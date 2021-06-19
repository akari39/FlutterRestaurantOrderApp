import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wireless_order_system/widget/home.dart';
import 'package:wireless_order_system/widget/start.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  static SystemUiOverlayStyle style = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark
  );

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(MyApp.style);

    return MaterialApp(
      initialRoute: '/start',
      routes: {
        '/': (context) => Home(),
        '/start': (context) => StartWidget()
      },
      title: 'Startup Name Generator',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.amber,
        primaryColor: Color(0xffE3A20E),
        accentColor: Color(0xff222222),
        splashColor: Color(0xffE3A20E).withAlpha(42),
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
    );
  }
}