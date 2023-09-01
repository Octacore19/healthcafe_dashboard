import 'package:collection/collection.dart';
import 'package:healthcafe_dashboard/data/local/constants.dart';
import 'package:healthcafe_dashboard/data/local/model/user/user.dart';
import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:hive/hive.dart';

abstract class IBaseRepo {
  final _box = Hive.box<HiveUser>(adminBox);

  AuthUser? get currentUser {
    final user = _box.values.firstOrNull;
    return user == null ? null : AuthUser.fromHive(user);
  }
}
