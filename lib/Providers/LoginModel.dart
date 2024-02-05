import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Auth {
  late String uerId;
  late String FCMToken;
}

class LoginModel extends ChangeNotifier {
  bool _isLogin = false;

  Auth _auth = Auth()..uerId = '';

  Auth get auth => _auth;

  void setUserId(String userId) {
    _auth = Auth()..uerId = userId;
  }

  final bool _isLoadingLogin = false;

  bool get isLogin => _isLogin;

  bool get isLoadingLogin => _isLoadingLogin;

  final dio = Dio();

  void login(String id) async {
    setUserId(id);
    _isLogin = true;

    notifyListeners();
  }

  void logout() {
    _isLogin = false;
    notifyListeners();
  }
}
