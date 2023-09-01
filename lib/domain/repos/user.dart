import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/domain/repos/base.dart';

abstract class UserRepo with BaseRepo {
  Stream<List<AuthUser>> get users;

  AuthUser? get currentUser;

  Future<void> fetchUsersList();
}
