import 'package:flutter/cupertino.dart';

enum Env {
  DEV,
  QA,
  PRODUCTION
}

class OrderAppConfig {
  final Env env;
  final String uri;
  static OrderAppConfig _instance;

  factory OrderAppConfig ({
    @required Env env,
    String uri: "https://127.0.0.1/"}) {
    _instance ??= OrderAppConfig._internal(env,uri);
    return _instance;
  }

  OrderAppConfig._internal(this.env, this.uri);

  static OrderAppConfig get instance {return _instance;}
  static bool isProduction() => _instance.env == Env.PRODUCTION;
  static bool isDevelopment() => _instance.env == Env.DEV;
  static bool isQA() => _instance.env == Env.QA;
}