import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/domain/repos/user_repo.dart';

part 'auth_events.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  AuthBloc(this._userRepo) : super(const AuthUnknownState()) {
    _authSubscription = _userRepo.authUser.listen((user) {
      add(UpdateAuthState(user));
    });

    on<UpdateAuthState>(_onUpdateAuthStateEvent);
  }

  final UserRepo _userRepo;
  late final StreamSubscription _authSubscription;

  void _onUpdateAuthStateEvent(UpdateAuthState event, Emitter emitter) {
    final user = event.user;
    if (user == null) {
      emitter(const UnauthenticatedState());
    } else if (user.isEmpty) {
      emitter(const UnauthenticatedState());
    } else if (!user.isEmpty) {
      emitter(AuthenticatedState(user));
    } else {
      emitter(const AuthUnknownState());
    }
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
