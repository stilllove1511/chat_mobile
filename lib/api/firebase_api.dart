import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final token = await _firebaseMessaging.getToken();
    print('Firebase token: $token');
  }

//   void handleMessage(RemoteMessage message) {
//     if (message.notification == null) {
//       return;
//     }

//     print('onMessage data: ${message.data}');
//   }

//   Future initPushNotification() async {
//     FirebaseMessaging.instance.getInitialMessage().then((message) => handleMessage(message!));

//     FirebaseMessaging.onMessage.listen(handleMessage);
//   }
}
