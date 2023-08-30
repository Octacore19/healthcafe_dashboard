import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthcafe_dashboard/data/local/constants.dart';
import 'package:healthcafe_dashboard/data/local/model/user/user.dart';
import 'package:healthcafe_dashboard/data/remote/auth_service.dart';
import 'package:healthcafe_dashboard/data/remote/models/user.dart';
import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/domain/repos/auth_repo.dart';
import 'package:healthcafe_dashboard/domain/repos/base_repo.dart';
import 'package:healthcafe_dashboard/domain/requests/login_request.dart';
import 'package:collection/collection.dart';
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

  void _listenToUserChanges() {
    _userSub = _auth.authStateChanges().listen((mUser) async {
      if (mUser != null) {
        final aUser = await _db
            .collection('users')
            .withConverter(
              fromFirestore: UserResponse.fromFirestore,
              toFirestore: (UserResponse res, _) => res.toJson(),
            )
            .doc(mUser.uid)
            .get();
        final hiveUser = aUser.data()?.toHive;
        if (hiveUser != null) {
          await _box.clear();
          _box.put(hiveUser.uid, hiveUser);
          print('Data added: ${_box.values}');
        }
      }
    });
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
