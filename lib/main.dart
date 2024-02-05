import 'package:chat_mobile/Providers/auth_provider.dart';
import 'package:chat_mobile/Providers/messaging_provider.dart';
import 'package:chat_mobile/Screens/dialogs_screen.dart';
import 'package:chat_mobile/Screens/login_screen.dart';
import 'package:chat_mobile/Screens/chat_screen.dart';
import 'package:chat_mobile/config/firebase_options.dart';
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
        ListenableProvider<AuthProvider>(create: (context) => AuthProvider()),
        ListenableProvider<MessagingProvider>(create: (context) => MessagingProvider()),
      ],
      child: MaterialApp(
        home: const LoginScreen(),
        routes: {
          '/listDialog': (context) => const ListDialogScreen(),
          '/login': (context) => const LoginScreen(),
          '/chat': (context) => const ChatScreen()
        },
      ),
    );
  }
}
