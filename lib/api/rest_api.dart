import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  static BaseOptions options =
      BaseOptions(baseUrl: dotenv.env['API_URL'] ?? '');
  Dio dio = Dio(options);

  Future<void> login({required String userId, required String FCMToken}) {
    return dio
        .post('/account/login', data: {'id': userId, 'FCMToken': FCMToken});
  }

  Future<dynamic> fetchDialog(String userId) {
    return dio.get('/dialog/get_all',
        options: Options(headers: {
          'authorization': userId,
        }));
  }
}
