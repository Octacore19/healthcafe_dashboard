import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcafe_dashboard/domain/models/appointment.dart';
import 'package:healthcafe_dashboard/domain/repos/appointment_repo.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit({
    required AppointmentRepo appointmentRepo,
  })  : _repo = appointmentRepo,
        super(const InitialState()) {
    _appointmentsSub = _repo.appointments.listen((values) {
      emit(UpdatedState(appointments: values));
    });
  }

  final AppointmentRepo _repo;

  StreamSubscription<List<Appointment>>? _appointmentsSub;

  @override
  Future<void> close() {
    _appointmentsSub?.cancel();
    _appointmentsSub = null;
    return super.close();
  }
}
