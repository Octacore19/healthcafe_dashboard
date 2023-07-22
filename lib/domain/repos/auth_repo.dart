import 'package:healthcafe_dashboard/domain/requests/login_request.dart';

abstract class AuthRepo {
  Future<void> login(LoginRequest request);
}
