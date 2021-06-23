import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:sprintf/sprintf.dart';

part 'wos_network.g.dart';

class WOSNetwork {
  static final WOSNetwork _wosnetwork = WOSNetwork();
  static final http.Client _client = http.Client();
  static final String _api = "app.xiofan2.com";

  static final String getMenu = "/api/menuKind/getAllDishesByChildDesk";
  static final String getRestaurant = "/api/menuKind/getRestaurantByChildDesk";
  //static final String getRestaurant
  static final String postOrder = "/api/order/operate";

  Map<String, String> get _headers {
    return {
      "Content-Type": "application/json; charset=utf-8",
    };
  }

  static WOSNetwork get instance {
    return _wosnetwork;
  }

  Future<void> get(String route, Map<String, dynamic> params, Function callback) async {
    var response;
    try {
      http.Response uriResponse = await _client.get(Uri.http(_api, route, params), headers: this._headers);
      var apiResponse = ApiResponse.fromJson(json.decode(uriResponse.body));
      if(apiResponse.success) {
        if(apiResponse.data != null) {
          response = apiResponse.data;
        } else if(apiResponse.message != null) {
          response = apiResponse.message;
        } else {
          response = null;
        }
        await callback(response);
        return;
      } else {
        Fluttertoast.showToast(msg: apiResponse.data.toString());
      }
    } catch(e, stacktrace) {
      log(e.toString(), name: "WOSNetwork", stackTrace: stacktrace);
      Fluttertoast.showToast(msg: "服务器错误"+e.toString());
    }
    await callback(null);
  }

  Future<void> post(String route, String body, Function callback) async{
    var response;
    try {
      http.Response uriResponse = await _client.post(Uri.parse("http://"+_api+route), headers: _headers, body: body);
      log(Uri.parse("http://"+_api+route).toString(), name: "WOSNetwork");
      log(uriResponse.body, name: "WOSNetwork");
      var apiResponse = ApiResponse.fromJson(json.decode(uriResponse.body));
      if(apiResponse.success) {
        response = apiResponse.data;
      } else {
        Fluttertoast.showToast(msg: "请求失败");
      }
    } catch(e) {
      log(e.toString());
      Fluttertoast.showToast(msg: "服务器错误"+e.toString());
    }
    await callback(response);
  }

  Future<void> delete(String route, String body, Function callback) async {
    var data;
    try {
      http.Response uriResponse = await _client.delete(Uri.parse(_api+route), headers: _headers, body: body);
      var apiResponse = ApiResponse.fromJson(json.decode(uriResponse.body));
      log(uriResponse.body, name: "WOSNetwork");
      if(apiResponse.success) {
        data = apiResponse.data;
      } else {
        Fluttertoast.showToast(msg: "请求失败");
      }
    } catch(e, stacktrace) {
      log(e.toString(), name: "WOSNetwork", stackTrace: stacktrace);
      Fluttertoast.showToast(msg: "服务器错误"+e.toString());
    }
    await callback(data);
  }

}

extension StringFormatExtension on String {
  String format(var arguments) => sprintf(this, arguments);
}

@JsonSerializable()
class ApiResponse {
  bool success;
  String? message;
  bool? notLogin;
  dynamic data;

  ApiResponse({required this.success, required this.message, required this.notLogin, required this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}