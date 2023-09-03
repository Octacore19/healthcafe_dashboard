import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/domain/repos/base.dart';
import 'package:healthcafe_dashboard/domain/requests/profile.dart';

abstract class UserRepo with BaseRepo {
  Stream<List<AuthUser>> get users;

  Future<void> fetchUsersList();
}
