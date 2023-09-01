import 'dart:async';

import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthcafe_dashboard/data/local/constants.dart';
import 'package:healthcafe_dashboard/data/local/model/user/user.dart';
import 'package:healthcafe_dashboard/data/remote/models/user.dart';
import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/domain/repos/user.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/rxdart.dart';

class IUserRepo implements UserRepo {
  IUserRepo({required FirebaseFirestore firestore}) : _db = firestore {
    final res = _userCollection
        .snapshots()
        .map((e) => e.docs.map((e) => e.data().toHive).toList());
    _usersSub = res.listen((values) {
      List<HiveUser> existing = _box.values.toList();
      if (existing.isNotEmpty) {
        for (var hive in existing) {
          final found = values.firstWhereOrNull((e) => e.uid == hive.uid);
          found == null ? hive.delete() : _box.put(found.uid, found);
        }
      } else {
        final users = {for (var v in values) v.uid: v};
        _box.putAll(users);
      }
    });
    _usersSub?.cancel();
  }

  final FirebaseFirestore _db;

  StreamSubscription? _usersSub;
  final _box = Hive.box<HiveUser>(userBox);
  final _adminBox = Hive.box<HiveUser>(adminBox);

  Query<UserResponse> get _userCollection {
    return _db
        .collection('users')
        .where("admin", isEqualTo: false)
        .withConverter(
          fromFirestore: UserResponse.fromFirestore,
          toFirestore: (UserResponse res, _) => res.toJson(),
        );
  }

  @override
  Future<void> fetchUsersList() async {
    _usersSub?.resume();
    await _userCollection.get().then((value) async {
      List<HiveUser> existing = _box.values.toList();
      List<HiveUser> newData = value.docs.map((e) => e.data().toHive).toList();
      if (existing.isNotEmpty) {
        for (var hive in existing) {
          final found = newData.firstWhereOrNull((e) => e.uid == hive.uid);
          found == null ? hive.delete() : _box.put(found.uid, found);
        }
      } else {
        final hiveUsers = {for (var value in newData) value.uid: value};
        _box.putAll(hiveUsers);
      }
    });
  }

  @override
  AuthUser? get currentUser {
    final user = _adminBox.values.firstOrNull;
    return user == null ? null : AuthUser.fromHive(user);
  }

  @override
  Stream<List<AuthUser>> get users =>
      _box.watch().map((_) => _users).startWith(_users);

  List<AuthUser> get _users {
    return _box.values.map(AuthUser.fromHive).toList();
  }

  @override
  Future<void> close() async {
    _usersSub?.cancel();
  }
}
