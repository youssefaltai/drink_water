import 'package:drink_water/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

part 'dio.provider.g.dart';

@Riverpod(keepAlive: true)
Dio api(ApiRef ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.8:3000',
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        logger.d('Request: ${options.method} ${options.path} ${options.data}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        logger.d(
            'Response: ${response.statusCode} ${response.statusMessage} ${response.data}');
        return handler.next(response);
      },
      onError: (error, handler) {
        logger.e('Error: ${error.message}');
        return handler.next(error);
      },
    ),
  );

  return dio;
}
