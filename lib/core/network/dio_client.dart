import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants/app_constants.dart';
import '../errors/exceptions.dart';

part 'dio_client.g.dart';

@riverpod
Dio dioClient(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: AppConstants.connectTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
      headers: {'Content-Type': 'application/json'},
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (DioException e, handler) {
        switch (e.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.receiveTimeout:
          case DioExceptionType.sendTimeout:
            return handler.reject(e.copyWith(error: const NetworkException('Connection timed out')));
          case DioExceptionType.connectionError:
            return handler.reject(e.copyWith(error: const NoInternetException()));
          case DioExceptionType.badResponse:
            return handler.reject(
              e.copyWith(error: ServerException(e.response?.statusMessage ?? 'Server error', statusCode: e.response?.statusCode)),
            );
          default:
            return handler.next(e);
        }
      },
    ),
  );

  return dio;
}
