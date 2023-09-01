import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/domain/repos/auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(AuthRepo authRepo) : super(const AuthUnknownState()) {
    _authSubscription = authRepo.authUser.listen((user) {
      _onUpdateAuthStateEvent(user);
    });
  }

  late final StreamSubscription _authSubscription;

  void _onUpdateAuthStateEvent(AuthUser? user) {
    if (user == null) {
      emit(const UnauthenticatedState());
    } else if (user.isEmpty) {
      emit(const UnauthenticatedState());
    } else if (!user.isEmpty) {
      emit(AuthenticatedState(user));
    } else {
      emit(const AuthUnknownState());
    }
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
