import 'package:dio/dio.dart';
import 'package:healthcafe_dashboard/config/env_config.dart';
import 'package:healthcafe_dashboard/data/remote/auth_service.dart';

class AuthServiceImpl implements AuthService {
  AuthServiceImpl(this._config);

  final EnvConfig _config;

  Dio get _dio {
    final options = BaseOptions(
      baseUrl: _config.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );
    final d = Dio(options);
    d.interceptors.addAll([
      LogInterceptor(responseBody: true, requestBody: true),
    ]);
    return d;
  }

  @override
  Future createUser(Map<String, dynamic> data) {
    return _dio.post(
      '/auth/signup',
      data: data,
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
  }

  @override
  Future loginUser(Map<String, dynamic> data) {
    return _dio.post(
      '/auth/login',
      data: data,
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
  }

  @override
  Future sendOtp(Map<String, String> data) {
    return _dio.post(
      '/auth/send-otp',
      data: data,
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
  }
}
