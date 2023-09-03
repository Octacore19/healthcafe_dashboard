import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/domain/requests/login.dart';
import 'package:healthcafe_dashboard/domain/requests/profile.dart';

abstract class AuthRepo {
  Stream<AuthUser?> get authUser;

  AuthUser? get currentUser;

  Future<void> login(LoginRequest request);

  Future<void> updateAdminProfile(ProfileRequest request);
}
