import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/domain/repos/auth.dart';
import 'package:healthcafe_dashboard/domain/requests/login.dart';
import 'package:healthcafe_dashboard/utils/cred_utils.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(const InitialState()) {
    _emailController = TextEditingController();
    _pwdController = TextEditingController();
  }

  final AuthRepo _authRepo;

  StreamSubscription<AuthUser?>? _userSub;

  TextEditingController? _emailController;

  TextEditingController? _pwdController;

  TextEditingController? get emailController => _emailController;

  TextEditingController? get pwdController => _pwdController;

  void onLoginClicked() async {
    final email = _emailController?.text.trim();
    final pwd = _pwdController?.text.trim();
    emit(LoadingState());
    try {
      if (email?.isEmpty == true) {
        emit(const ErrorState('Email cannot be empty'));
      } else if (!CredUtils.isValidEmail(email)) {
        emit(const ErrorState('Enter a valid email'));
      } else if ((pwd?.length ?? 0) < 4) {
        emit(const ErrorState('Password is not strong enough'));
      } else {
        final request = LoginRequest(email: email, password: pwd);
        await _authRepo.login(request);
        await Future.delayed(const Duration(milliseconds: 1000));
        emit(SuccessState());
      }
    } on DioException catch (e) {
      final res = e.response?.data;
      if (res != null) {
        emit(ErrorState(res['message']));
      }
    } on Exception catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _userSub?.cancel();
    _emailController?.dispose();
    _pwdController?.dispose();
    return super.close();
  }
}
