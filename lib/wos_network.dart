import 'package:http/http.dart' as http;

import 'me.dart';

class WOSNetwork {
  static final WOSNetwork _wosnetwork = WOSNetwork();
  static final http.Client _client = http.Client();
  static final String _api = "http://127.0.0.1";
  static Map<String, String> get headers {
    return {
      "Content-Type": "application/json; charset=utf8",
      "Authorization": Me.getInstance().token ?? ""
    };
  }

  WOSNetwork get instance {
    return _wosnetwork;
  }

  void get(String route, Map<String, dynamic> params, Function callback) {

  }

  void post(String route, Map<String, dynamic> json, Function callback) {

  }

  void delete(String route, Map<String, dynamic> json, Function callback) {

  }

}