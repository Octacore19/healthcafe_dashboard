import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/domain/requests/login.dart';

abstract class AuthRepo {
  Stream<AuthUser?> get authUser;

  Future<void> login(LoginRequest request);
}
