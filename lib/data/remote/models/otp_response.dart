class OtpResponse {
  final String? message;
  final bool? status;

  OtpResponse._(this.status, this.message);

  factory OtpResponse.fromJson(Map<String, dynamic>? json) {
    return OtpResponse._(json?['status'], json?['message']);
  }
}
