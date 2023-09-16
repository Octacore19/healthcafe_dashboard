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
    _usersSub = res.listen((values) async {
      await _box.clear();
      final hiveUsers = { for (var value in values) value.uid: value };
      await _box.putAll(hiveUsers);
    });
    _usersSub?.cancel();
  }

  final FirebaseFirestore _db;

  StreamSubscription? _usersSub;
  final _box = Hive.box<HiveUser>(userBox);

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
      List<HiveUser> newData = value.docs.map((e) => e.data().toHive).toList();
      await _box.clear();
      final hiveUsers = {for (var value in newData) value.uid: value};
      await _box.putAll(hiveUsers);
    });
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
