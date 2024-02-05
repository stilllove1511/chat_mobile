import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Auth {
  Auth({required this.uerId});

  late String uerId;
}

class AuthProvider extends ChangeNotifier {
  bool _isLogin = false;

  Auth? _auth;

  Auth? get auth => _auth;

  final bool _isLoadingLogin = false;

  bool get isLogin => _isLogin;

  bool get isLoadingLogin => _isLoadingLogin;

  final dio = Dio();

  void login(String id) async {
    _auth = Auth(
      uerId: id,
    );
    
    _isLogin = true;

    notifyListeners();
  }

  void logout() {
    _isLogin = false;
    notifyListeners();
  }
}
