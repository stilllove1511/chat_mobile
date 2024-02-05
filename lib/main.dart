import 'package:chat_mobile/Providers/LoginModel.dart';
import 'package:chat_mobile/Providers/MessagingProvider.dart';
import 'package:chat_mobile/Screens/dialogs.dart';
import 'package:chat_mobile/Screens/login.dart';
import 'package:chat_mobile/Screens/chat.dart';
import 'package:chat_mobile/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginModel>(create: (context) => LoginModel()),
        Provider<MessagingProvider>(create: (context) => MessagingProvider()),
      ],
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
