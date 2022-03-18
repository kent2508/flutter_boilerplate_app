import 'dart:developer';

import 'package:dio/dio.dart';

class AppInterceptorLogging extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('*** Request ***');
    print('REQUEST[${options.method}] => ${options.uri}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('*** Response ***');
    print('RESPONSE[${response.statusCode}] => ${response.realUri}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log('*** Error ***');
    print(
      'ERROR[${err.response?.data?['code'] ?? err.response?.statusCode}] => ${err.requestOptions.uri} WITH MESSAGE: ${err.response?.data?['message'] ?? err.message}',
    );
    return super.onError(err, handler);
  }
}
