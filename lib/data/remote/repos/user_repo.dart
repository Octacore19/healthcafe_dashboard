import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:healthcafe_dashboard/data/remote/models/user_response.dart';
import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/domain/repos/user_repo.dart';

class IUserRepo implements UserRepo {
  IUserRepo({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  })  : _auth = firebaseAuth,
        _db = firebaseFirestore;

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

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
        debugPrint('User => $authUser');
      }
      return authUser;
    });
  }
}
