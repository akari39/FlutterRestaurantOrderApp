import 'package:shared_preferences/shared_preferences.dart';

class Me{
  static final Me _me = Me();

  static Me getInstance() => _me;

  int? userId;
  String? username;
  String? token;

  void save() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("user_id", userId);
    prefs.setString("username", username);
    prefs.setString("token", token);
  }
}