
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MessagingProvider with ChangeNotifier {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  String _token = '';

  String get token => _token;

  MessagingProvider() {
    _init();
  }

  void _init() {
    _firebaseMessaging.getToken().then((token) {
      _token = token!;
      notifyListeners();
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle incoming message
      print("Received message: ${message.data}");
    });
  }
}
