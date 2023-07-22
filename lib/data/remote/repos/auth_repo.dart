import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthcafe_dashboard/data/remote/auth_service.dart';
import 'package:healthcafe_dashboard/data/remote/models/user_response.dart';
import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/domain/repos/auth_repo.dart';
import 'package:healthcafe_dashboard/domain/requests/login_request.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl({
    required AuthService service,
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  })  : _service = service,
        _firebaseAuth = firebaseAuth,
        _db = firestore;

  final AuthService _service;
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _db;

  @override
  Stream<AuthUser?> get authUser {
    return _firebaseAuth.authStateChanges().asyncMap((mUser) async {
      AuthUser? authUser;
      if (mUser != null) {
        await _db
            .collection('users')
            .withConverter(
              fromFirestore: UserResponse.fromFirestore,
              toFirestore: (UserResponse res, _) => res.toJson(),
            )
            .doc(mUser.uid)
            .get();
      }
      return authUser;
    });
  }

  @override
  Future<void> login(LoginRequest request) async {
    final res = await _service.loginUser(request.toJson());
    if (res.accessToken != null) {
      await _firebaseAuth.signInWithCustomToken(res.accessToken!);
    }
  }
}
