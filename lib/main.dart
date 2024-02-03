import 'package:chat_mobile/Models/LoginModel.dart';
import 'package:chat_mobile/Screens/Dialogs/index.dart';
import 'package:chat_mobile/Screens/Login/index.dart';
import 'package:chat_mobile/Screens/Chat/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
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
