part of 'dashboard_cubit.dart';

abstract class DashboardState extends Equatable {
  const DashboardState({
    required this.users,
    required this.appointments,
  });

  final List<AuthUser> users;
  final List<Appointment> appointments;

  @override
  List<Object?> get props => [users, appointments];
}

class InitialState extends DashboardState {
  const InitialState({
    super.users = const [],
    super.appointments = const [],
  });
}

class UpdatedState extends DashboardState {
  const UpdatedState({
    required super.users,
    required super.appointments,
  });
}
