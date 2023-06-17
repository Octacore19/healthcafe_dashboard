abstract class AuthService {
  Future<dynamic> sendOtp(Map<String, String> data);

  Future<dynamic> createUser(Map<String, dynamic> data);

  Future<dynamic> loginUser(Map<String, dynamic> data);
}