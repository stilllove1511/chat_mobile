import 'package:chat_mobile/Models/LoginModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:chat_mobile/Screens/login.dart';

class ListDialog extends StatelessWidget {
  const ListDialog({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    final loginModel = Provider.of<LoginModel>(context);

    final Stream<LoginModel> loginModelStream =
        Stream.value(Provider.of<LoginModel>(context));

    if (!loginModel.isLogin) {
      // Navigator.pushNamed(context, '/login');
      return const LoginScreen();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(loginModel.auth.uerId),
        ),
        body: StreamBuilder<LoginModel>(
          stream: loginModelStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isLogin) {
              return FutureBuilder<List<Dialog>>(
                future: fetchDialog(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text('${snapshot.data![index].userIds}'),
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

                  return Text('no data');
                },
              );
            } else {
              return Text('not login');
            }
          },
        )
        // body: FutureBuilder<List<Dialog>>(
        //   future: futureDialogs,
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return ListView.builder(
        //         itemCount: snapshot.data!.length,
        //         itemBuilder: (context, index) {
        //           return ListTile(
        //             leading: const CircleAvatar(
        //               child: Icon(Icons.person),
        //             ),
        //             title: Text('${snapshot.data![index].userIds}'),
        //             subtitle: const Text('Last message'),
        //             onTap: () {
        //               Navigator.pushNamed(context, '/chat');
        //             },
        //           );
        //         },
        //       );
        //     } else if (snapshot.hasError) {
        //       return Text('${snapshot.error}');
        //     }

        //     return const CircularProgressIndicator();
        //   },
        // )
        );
  }
}

class Dialog {
  final String id;
  final List<String> userIds;

  Dialog({required this.id, required this.userIds});
}

Future<List<Dialog>> fetchDialog() async {
  final baseUrl = dotenv.env['API_URL'];

  final response = await Dio().get('$baseUrl/dialog/get_all',
      options: Options(headers: {
        'authorization': 'me',
      }));

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
