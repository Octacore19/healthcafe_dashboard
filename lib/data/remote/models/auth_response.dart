import 'dart:convert';

class AuthResponse {
  final String? accessToken;
  final bool? status;

  AuthResponse._({
    this.accessToken,
    this.status,
  });

  factory AuthResponse.fromJson(dynamic json) {
    return AuthResponse._(
      status: json?['status'],
      accessToken: json?['access_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'access_token': accessToken,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
