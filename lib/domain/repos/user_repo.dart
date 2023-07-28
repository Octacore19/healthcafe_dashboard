import 'package:healthcafe_dashboard/domain/models/auth_user.dart';

abstract class UserRepo {
  Stream<AuthUser?> get authUser;

  Stream<List<AuthUser>> get users;
}
