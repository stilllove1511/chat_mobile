import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Auth {
  late String uerId;
}

class LoginModel extends ChangeNotifier {
  bool _isLogin = false;

  Auth? _auth;

  Auth? get auth => _auth;

  void setUserId(String userId) {
    _auth = Auth()..uerId = userId;
  }

  final bool _isLoadingLogin = false;

  bool get isLogin => _isLogin;

  bool get isLoadingLogin => _isLoadingLogin;

  final dio = Dio();

  void login(String id) async {
    try {
    final baseUrl = dotenv.env['API_URL'];
    final response = await dio.post(
      '$baseUrl/account/login',
      data: {
        'id': id,
      },
    );

    setUserId(response.data['id']);
    _isLogin = true;
    } catch (e) {
      setUserId('');
      _isLogin = false;
    }

    notifyListeners();
  }

  void logout() {
    _isLogin = false;
    notifyListeners();
  }
}
