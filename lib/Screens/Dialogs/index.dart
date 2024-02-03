import 'package:chat_mobile/Models/LoginModel.dart';
import 'package:chat_mobile/Screens/Login/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListDialog extends StatelessWidget {
  const ListDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final loginModel = Provider.of<LoginModel>(context);

    if (!loginModel.isLogin) {
      // Navigator.pushNamed(context, '/login');
      return const LoginScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with the actual number of chat dialogs
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              // Replace with the chat dialog's avatar
              child: Icon(Icons.person),
            ),
            title: Text(
                'Chat Dialog $index'), // Replace with the chat dialog's title
            subtitle: const Text(
                'Last message'), // Replace with the last message of the chat dialog
            onTap: () {
              Navigator.pushNamed(context, '/chat');
            },
          );
        },
      ),
    );
  }
}
