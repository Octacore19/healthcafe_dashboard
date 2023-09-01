import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/domain/models/appointment.dart';
import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/domain/repos/appointment.dart';
import 'package:healthcafe_dashboard/domain/repos/user.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit({
    required UserRepo repo,
    required AppointmentRepo appointmentRepo,
    required String? userId,
  })  : _repo = repo,
        _appointmentRepo = appointmentRepo,
        super(const InitialState()) {
    _appointmentSub = _appointmentRepo.appointments.listen((values) {
      emit(UpdatedState(appointments: values, user: state.user));
    });

    _usersSub = _repo.users.listen((values) {
      final user = values.firstWhereOrNull((e) => e.id == userId);
      emit(UpdatedState(user: user, appointments: state.appointments));
    });
  }

  final UserRepo _repo;

  final AppointmentRepo _appointmentRepo;

  StreamSubscription<List<Appointment>>? _appointmentSub;

  StreamSubscription<List<AuthUser>>? _usersSub;

  @override
  Future<void> close() {
    _usersSub?.cancel();
    _appointmentSub?.cancel();
    _usersSub = null;
    _appointmentSub = null;
    return super.close();
  }
}
