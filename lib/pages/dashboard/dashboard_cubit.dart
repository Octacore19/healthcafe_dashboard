import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/domain/models/appointment.dart';
import 'package:healthcafe_dashboard/domain/models/auth_user.dart';
import 'package:healthcafe_dashboard/domain/repos/appointment_repo.dart';
import 'package:healthcafe_dashboard/domain/repos/user_repo.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({
    required UserRepo userRepo,
    required AppointmentRepo appointmentRepo,
  })  : _userRepo = userRepo,
        _appointmentRepo = appointmentRepo,
        super(const InitialState()) {
    _usersSub = _userRepo.users.listen((users) {
      emit(UpdatedState(
        users: users,
        appointments: state.appointments,
      ));
    });

    _appointmentsSub = _appointmentRepo.appointments.listen((values) {
      emit(UpdatedState(users: state.users, appointments: values));
    });
  }

  final UserRepo _userRepo;
  final AppointmentRepo _appointmentRepo;

  StreamSubscription<List<AuthUser>>? _usersSub;
  StreamSubscription<List<Appointment>>? _appointmentsSub;

  @override
  Future<void> close() {
    _usersSub?.cancel();
    _appointmentsSub?.cancel();
    _usersSub = null;
    _appointmentsSub = null;
    return super.close();
  }
}
