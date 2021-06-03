import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

import 'me.dart';

part 'wos_network.g.dart';

class WOSNetwork {
  static final WOSNetwork _wosnetwork = WOSNetwork();
  static final http.Client _client = http.Client();
  static final String _api = "http://128.199.161.136";
  Map<String, String> get _headers {
    return {
      "Content-Type": "application/json; charset=utf8",
      "Authorization": Me.getInstance().token ?? ""
    };
  }

  WOSNetwork get instance {
    return _wosnetwork;
  }

  void get(String route, Map<String, dynamic> params, Function callback) async{
    try {
      http.Response uriResponse = await _client.get(Uri.http(_api, route, params), headers: this._headers);
      var apiResponse = ApiResponse.fromJson(json.decode(uriResponse.body));
      if(apiResponse.success) {

        callback(apiResponse.response);
      } else {
        Fluttertoast.showToast(msg: "请求失败");
      }
    } catch(e) {
      Fluttertoast.showToast(msg: "服务器错误"+e.toString());
    }
  }

  void post(String route, Map<String, dynamic> json, Function callback) {

  }

  void delete(String route, Map<String, dynamic> json, Function callback) {

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