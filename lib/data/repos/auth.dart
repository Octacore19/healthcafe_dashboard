import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthcafe_dashboard/data/local/constants.dart';
import 'package:healthcafe_dashboard/data/local/model/user/user.dart';
import 'package:healthcafe_dashboard/data/remote/auth_service.dart';
import 'package:healthcafe_dashboard/data/remote/models/user.dart';
import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/domain/repos/auth.dart';
import 'package:healthcafe_dashboard/domain/repos/base.dart';
import 'package:healthcafe_dashboard/domain/requests/login.dart';
import 'package:collection/collection.dart';
import 'package:healthcafe_dashboard/domain/requests/profile.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

class IAuthRepo with BaseRepo implements AuthRepo {
  IAuthRepo({
    required AuthService service,
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  })  : _service = service,
        _auth = firebaseAuth,
        _db = firebaseFirestore {
    _listenToUserChanges();
  }

  final AuthService _service;
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  final _box = Hive.box<HiveUser>(adminBox);
  StreamSubscription? _userSub;

  @override
  AuthUser? get currentUser {
    final user = _box.isNotEmpty ? _box.getAt(0) : null;
    return user == null ? null : AuthUser.fromHive(user);
  }

  @override
  Stream<AuthUser?> get authUser =>
      userStream.map((e) => e.map(AuthUser.fromHive).firstOrNull);

  @override
  Future<void> login(LoginRequest request) async {
    final res = await _service.loginUser(request.toJson());
    if (res.accessToken != null) {
      await _auth.signInWithCustomToken(res.accessToken!);
    }
    await Future.delayed(const Duration(milliseconds: 800));
  }

  @override
  Future<void> updateAdminProfile(ProfileRequest request) async {
    await _service.updateUser(currentUser?.id, request.toJson());
    _fetchUser(currentUser?.id);
  }

  void _listenToUserChanges() {
    _userSub = _auth.authStateChanges().listen((mUser) async {
      if (mUser != null) {
        _fetchUser(mUser.uid);
      }
    });
  }

  void _fetchUser(String? id) async {
    final aUser = await _db
        .collection('users')
        .withConverter(
          fromFirestore: UserResponse.fromFirestore,
          toFirestore: (UserResponse res, _) => res.toJson(),
        )
        .doc(id)
        .get();
    final hiveUser = aUser.data()?.toHive;
    if (hiveUser != null) {
      await _box.clear();
      _box.put(hiveUser.uid, hiveUser);
    }
  }

  Stream<List<HiveUser>> get userStream => _box
      .watch()
      .map((_) => _box.values.toList())
      .startWith(_box.values.toList());

  @override
  Future<void> close() async {
    _userSub?.cancel();
  }
}
