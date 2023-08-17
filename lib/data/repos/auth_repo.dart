import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthcafe_dashboard/data/remote/auth_service.dart';
import 'package:healthcafe_dashboard/domain/repos/auth_repo.dart';
import 'package:healthcafe_dashboard/domain/requests/login_request.dart';

class IAuthRepo implements AuthRepo {
  IAuthRepo({
    required AuthService service,
    required FirebaseAuth firebaseAuth,
  })  : _service = service,
        _auth = firebaseAuth;

  final AuthService _service;
  final FirebaseAuth _auth;

  @override
  Future<void> login(LoginRequest request) async {
    final res = await _service.loginUser(request.toJson());
    if (res.accessToken != null) {
      await _auth.signInWithCustomToken(res.accessToken!);
    }
  }
}
