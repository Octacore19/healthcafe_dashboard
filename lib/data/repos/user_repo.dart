import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthcafe_dashboard/data/local/constants.dart';
import 'package:healthcafe_dashboard/data/local/user.dart';
import 'package:healthcafe_dashboard/data/remote/models/user.dart';
import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/domain/repos/user_repo.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/rxdart.dart';

class IUserRepo implements UserRepo {
  IUserRepo({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  })  : _auth = firebaseAuth,
        _db = firebaseFirestore {

    final res = _userCollection
        .snapshots()
        .map((event) => event.docs.map((e) => e.data().toHive).toList());
    _usersSub = res.listen((event) {
      final users = {for (var v in event) v.uid: v};
      _userBox.putAll(users);
    });
    _usersSub?.cancel();
  }

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  StreamSubscription? _usersSub;
  final _userBox = Hive.box<HiveUser>(userBox);

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
    _userBox.clear();
    _userCollection.get().then((value) {
      for (var doc in value.docs) {
        final data = doc.data();
        _userBox.put(data.uid, data.toHive);
      }
    });
    _usersSub?.resume();
  }

  @override
  Stream<AuthUser?> get authUser {
    return _auth.authStateChanges().asyncMap((mUser) async {
      AuthUser? authUser;
      if (mUser != null) {
        final aUser = await _db
            .collection('users')
            .withConverter(
              fromFirestore: UserResponse.fromFirestore,
              toFirestore: (UserResponse res, _) => res.toJson(),
            )
            .doc(mUser.uid)
            .get();
        authUser = AuthUser.fromResponse(aUser.data());
      }
      return authUser;
    });
  }

  @override
  Stream<List<AuthUser>> get users =>
      _userBox.watch().map((_) => _users).startWith(_users);

  List<AuthUser> get _users {
    return _userBox.values.map(AuthUser.fromHive).toList();
  }

  @override
  Future<void> close() async {
    _usersSub?.cancel();
  }
}
