import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/domain/repos/user.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit({required UserRepo userRepo, String? id})
      : _userRepo = userRepo,
        super(const InitialState()) {
    _searchController = TextEditingController();

    _usersSub = _userRepo.users.listen((users) {
      emit(UpdatedState(users: users));
    });
  }

  final UserRepo _userRepo;

  StreamSubscription<List<AuthUser>>? _usersSub;

  TextEditingController? _searchController;

  TextEditingController? get searchController => _searchController;

  @override
  Future<void> close() {
    _searchController?.dispose();
    _usersSub?.cancel();
    _searchController = null;
    _usersSub = null;
    return super.close();
  }
}
