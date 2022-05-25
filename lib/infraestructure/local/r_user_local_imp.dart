import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../../application/repository/r_user_local.dart';
import '../../core/entities/e_login.dart';

class RUserLocalImp implements RUserLocal {
  static const String keyToken = 'token';
  @override
  Future<ELogin> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(keyToken);
    return Future.value(ELogin()..token = token);
  }

  @override
  Future<bool> saveToken(ELogin user) async {
    final prefs = await SharedPreferences.getInstance();
    final success = await prefs.setString(keyToken, user.token!);
    return Future.value(success);
  }

  @override
  Future<bool> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    final success = await prefs.remove(keyToken);
    return Future.value(success);
  }
}
