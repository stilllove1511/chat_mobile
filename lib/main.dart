import 'package:chat_mobile/Models/LoginModel.dart';
import 'package:chat_mobile/Screens/dialogs.dart';
import 'package:chat_mobile/Screens/login.dart';
import 'package:chat_mobile/Screens/chat.dart';
import 'package:chat_mobile/api/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginModel(),
      child: MaterialApp(
        home: const ListDialog(),
        initialRoute: '/listDialog',
        routes: {
          '/listDialog': (context) => const ListDialog(),
          '/login': (context) => const LoginScreen(),
          '/chat': (context) => ChatScreen()
        },
      ),
    );
  }
}
