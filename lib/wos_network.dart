import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

import 'me.dart';

part 'wos_network.g.dart';

class WOSNetwork {
  static final WOSNetwork _wosnetwork = WOSNetwork();
  static final http.Client _client = http.Client();
  static final String _api = "http://128.199.161.136:3000";
  Map<String, String> get _headers {
    return {
      "Content-Type": "application/json; charset=utf-8",
      if(Me.getInstance().token != null)
        "Authorization": Me.getInstance().token!
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
        response = apiResponse.response;
        log(response);
        return;
      } else {
        Fluttertoast.showToast(msg: apiResponse.response.toString());
      }
    } catch(e) {
      log(e.toString());
      Fluttertoast.showToast(msg: "服务器错误"+e.toString());
    }
    await callback(null);
  }

  Future<void> post(String route, String body, Function callback) async{
    var response;
    try {
      http.Response uriResponse = await _client.post(Uri.parse(_api+route), headers: _headers, body: body);
      var apiResponse = ApiResponse.fromJson(json.decode(uriResponse.body));
      if(apiResponse.success) {
        response = apiResponse.response;
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
    var response;
    try {
      http.Response uriResponse = await _client.delete(Uri.parse(_api+route), headers: _headers, body: body);
      var apiResponse = ApiResponse.fromJson(json.decode(uriResponse.body));
      if(apiResponse.success) {
        response = apiResponse.response;
      } else {
        Fluttertoast.showToast(msg: "请求失败");
      }
    } catch(e) {
      log(e.toString());
      Fluttertoast.showToast(msg: "服务器错误"+e.toString());
    }
    await callback(response);
  }

}

@JsonSerializable()
class ApiResponse {
  bool success;
  dynamic response;

  ApiResponse({required this.success, required this.response});

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}