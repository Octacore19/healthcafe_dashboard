part of 'appointment_cubit.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState({
    required this.appointments,
  });

  final List<Appointment> appointments;

  @override
  List<Object?> get props => [appointments];
}

class InitialState extends AppointmentState {
  const InitialState({super.appointments = const []});
}

class UpdatedState extends AppointmentState {
  const UpdatedState({required super.appointments});
}
