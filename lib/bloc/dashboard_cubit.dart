import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/domain/repos/user_repo.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({
    required UserRepo userRepo,
  })  : _userRepo = userRepo,
        super(const InitialState()) {
    _usersSub = _userRepo.users.listen((users) {
      emit(UpdatedState(users: users));
    });
  }

  final UserRepo _userRepo;

  StreamSubscription<List<AuthUser>>? _usersSub;

  @override
  Future<void> close() {
    _usersSub?.cancel();
    return super.close();
  }
}
