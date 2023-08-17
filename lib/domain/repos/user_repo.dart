import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/domain/repos/base_repo.dart';

abstract class UserRepo with BaseRepo {
  Stream<AuthUser?> get authUser;

  Stream<List<AuthUser>> get users;

  Future<void> fetchUsersList();
}
