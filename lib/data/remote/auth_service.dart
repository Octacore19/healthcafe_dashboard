import 'package:dio/dio.dart';
import 'package:healthcafe_dashboard/config/env_config.dart';
import 'package:healthcafe_dashboard/data/remote/models/auth.dart';

class AuthService {
  AuthService(this._config);

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

  Future<AuthResponse> loginUser(Map<String, dynamic> data) async {
    final res = await _dio.post(
      '/admin/login',
      data: data,
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    return AuthResponse.fromJson(res.data);
  }
}
