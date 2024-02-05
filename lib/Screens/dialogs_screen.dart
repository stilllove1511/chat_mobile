import 'package:chat_mobile/Providers/auth_provider.dart';
import 'package:chat_mobile/api/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_mobile/Screens/login_screen.dart';

class ListDialogScreen extends StatelessWidget {
  const ListDialogScreen({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    final loginModel = Provider.of<AuthProvider>(context);

    if (!loginModel.isLogin) {
      return const LoginScreen();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(loginModel.auth!.uerId),
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder<List<Dialog>>(
          future: fetchDialog(
            loginModel.auth!.uerId,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(snapshot.data![index].userIds[0]),
                    subtitle: const Text('Last message'),
                    onTap: () {
                      Navigator.pushNamed(context, '/chat');
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ));
  }
}

class Dialog {
  final String id;
  final List<String> userIds;

  Dialog({required this.id, required this.userIds});
}

Future<List<Dialog>> fetchDialog(String userId) async {
  final response = await RestApi().fetchDialog(userId);

  if (response.statusCode == 200) {
    return (response.data as List)
        .map((dialog) => Dialog(
              id: dialog['id'],
              userIds: (dialog['users'] as List)
                  .map((e) => e['id'] as String)
                  .toList(),
            ))
        .toList();
  } else {
    throw Exception('Failed to load dialog.');
  }
}
