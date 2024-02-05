import 'package:chat_mobile/Providers/auth_provider.dart';
import 'package:chat_mobile/Providers/messaging_provider.dart';
import 'package:chat_mobile/api/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  String email = '';
  String password = '';

  void setEmail(String value) {
    email = value;
  }

  void setPassword(String value) {
    password = value;
  }

  RestApi api = RestApi();

  @override
  Widget build(BuildContext context) {
    final loginModel = Provider.of<AuthProvider>(context);
    final messagingProvider = Provider.of<MessagingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onChanged: setEmail,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                onChanged: setPassword,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await api.login(
                    userId: email,
                    FCMToken: messagingProvider.token,
                  );
                  loginModel.login(email);
                  Navigator.pushNamed(context, '/listDialog');
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
