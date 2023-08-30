import 'dart:async';

import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthcafe_dashboard/data/local/constants.dart';
import 'package:healthcafe_dashboard/data/local/model/user/user.dart';
import 'package:healthcafe_dashboard/data/remote/models/user.dart';
import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/domain/repos/user_repo.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/rxdart.dart';

class IUserRepo implements UserRepo {
  IUserRepo({required FirebaseFirestore firestore}) : _db = firestore {
    final res = _userCollection
        .snapshots()
        .map((e) => e.docs.map((e) => e.data().toHive).toList());
    _usersSub = res.listen((event) {
      final users = {for (var v in event) v.uid: v};
      _box.putAll(users);
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
    await _box.clear();
    await _userCollection.get().then((value) async {
      for (var doc in value.docs) {
        final data = doc.data();
        _usersSub?.resume();
        await _box.put(data.uid, data.toHive);
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
