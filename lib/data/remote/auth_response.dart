class AuthResponse {
  final String? accessToken;
  final bool? status;
  final UserResponse? data;

  AuthResponse._({
    this.accessToken,
    this.status,
    this.data,
  });

  factory AuthResponse.fromJson(Map<String, dynamic>? json) {
    return AuthResponse._(
      status: json?['status'],
      accessToken: json?['access_token'],
      data: UserResponse.fromJson(json?['data']),
    );
  }
}

class UserResponse {
  final String? id;
  final String? email;
  final bool? emailVerified;
  final String? displayName;
  final String? phoneNumber;
  final bool? disabled;
  final String? creationTime;
  final String? lastSignInTime;
  final int? gender;
  final String? dob;

  UserResponse._({
    this.id,
    this.email,
    this.emailVerified,
    this.displayName,
    this.phoneNumber,
    this.disabled,
    this.creationTime,
    this.lastSignInTime,
    this.gender,
    this.dob,
  });

  factory UserResponse.fromJson(Map<String, dynamic>? json) {
    return UserResponse._(
      id: json?['uid'],
      email: json?['email'],
      emailVerified: json?['email_verified'],
      disabled: json?['disabled'],
      displayName: json?['display_name'],
      phoneNumber: json?['phone_number'],
      creationTime: json?['creation_time'],
      lastSignInTime: json?['last_sign_in_time'],
      gender: json?['gender'],
      dob: json?['dob'],
    );
  }
}
