import 'package:shared_preferences/shared_preferences.dart';

class Me{
  static final Me _me = Me();

  static Me getInstance() => _me;

  int? userId;
  String? username;
  String? token;

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    if(userId != null && username != null && token != null){
      prefs.setInt("user_id", userId!);
      prefs.setString("username", username!);
      prefs.setString("token", token!);
    }
  }

  Future<void> clear() async {
    userId = null;
    username = null;
    token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    this.userId = prefs.getInt("user_id");
    this.username = prefs.getString("username");
    this.token = prefs.getString("token");
  }

  bool isEmpty() {
    return userId == null || username == null || token == null;
  }
}