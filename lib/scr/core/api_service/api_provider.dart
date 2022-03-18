import 'dart:async';

import 'package:dio/dio.dart';
import 'package:vpb_flutter_boilerplate/scr/core/api_service/custom_exception.dart';

abstract class ApiProviderRepository {
  Future<Response<T>> getRequest<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    bool ignoreInvalidToken = false,
  });

  Future<Response<T>> postRequest<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool ignoreInvalidToken = false,
  });

  Future<Response<T>> putRequest<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool ignoreInvalidToken = false,
  });

  Future<Response<T>> deleteRequest<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool ignoreInvalidToken = false,
  });
}

class ApiProviderRepositoryImpl implements ApiProviderRepository {
  ApiProviderRepositoryImpl(this._dio);

  final Dio _dio;

  void setAccessToken(String token) {
    _dio.options.headers['Authorization'] = '$token';
  }

  // Map<String, String> defaultHeaders() {
  //   return {'content-type': 'application/json', 'accept': 'application/json', 'Authorization': 'Bearer ' + accessToken};
  // }

  @override
  Future<Response<T>> getRequest<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    onReceiveProgress,
    bool ignoreInvalidToken = false,
  }) async {
    try {
      final Response<T> response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on DioError catch (e) {
      throw _catchException(e);
    }
  }

  @override
  Future<Response<T>> postRequest<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    onSendProgress,
    onReceiveProgress,
    bool ignoreInvalidToken = false,
  }) async {
    try {
      final Response<T> response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
      );

      return response;
    } on DioError catch (e) {
      throw _catchException(e);
    }
  }

  @override
  Future<Response<T>> deleteRequest<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool ignoreInvalidToken = false,
  }) async {
    try {
      final Response<T> response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response;
    } on DioError catch (e) {
      throw _catchException(e);
    }
  }

  @override
  Future<Response<T>> putRequest<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    onSendProgress,
    onReceiveProgress,
    bool ignoreInvalidToken = false,
  }) async {
    try {
      final Response<T> response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on DioError catch (e) {
      throw _catchException(e);
    }
  }

  CustomException _catchException(DioError dioError) {
    // catch and custom error is here
    switch (dioError.type) {
      default:
        return CustomException('-101', 'Unknown Error');
    }
  }
}
