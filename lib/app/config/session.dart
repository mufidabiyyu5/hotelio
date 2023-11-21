import 'dart:convert';

import 'package:hotelio/app/modules/home/controllers/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../data/models/user_model.dart';

class Session {
  static Future<bool> saveUser(Users user) async {
    final pref = await SharedPreferences.getInstance();
    Map<String, dynamic> mapUser = user.toJson();
    String stringUser = json.encode(mapUser);
    bool success = await pref.setString('user', stringUser);
    if (success) {
      final cUser = Get.put(UserController());
      cUser.setData(user);
    }
    return success;
  }

  static Future<Users> getUser() async {
    Users user = Users();
    final pref = await SharedPreferences.getInstance();
    String? stringUser = pref.getString('user');
    if (stringUser != null) {
      Map<String, dynamic> mapUser = json.decode(stringUser);
      user = Users.fromJson(mapUser);
    }
    final cUser = Get.put(UserController());
    cUser.setData(user);
    return user;
  }

  static Future<bool> clearUser() async {
    Users user = Users();
    final pref = await SharedPreferences.getInstance();
    bool success = await pref.remove('user');
    final cUser = Get.put(UserController());
    cUser.setData(user);
    return success;
  }
}
