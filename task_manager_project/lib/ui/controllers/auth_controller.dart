import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_project/data/models/user_model.dart';

class AuthController {
  static String? token;
  static UserModel? user;

  static Future<void> saveUserInformation(
      String token, UserModel userModel) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    prefs.setString("user", jsonEncode(userModel.toJson()));
    token = token;
    user = userModel;
  }

  static Future<void> initializeUserCache() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
    final userJsonString = prefs.getString("user");
    if (userJsonString != null) {
      user = UserModel.fromJson(jsonDecode(userJsonString));
    }
  }

  static Future<bool> checkAuthState() async {
    await initializeUserCache();
    if (token == null) {
      return false;
    }
    return true;
  }

  static Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    token = null;
    user = null;
  }
}
