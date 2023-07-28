part of 'dashboard_cubit.dart';

abstract class DashboardState extends Equatable {
  const DashboardState({
    required this.users,
  });

  final List<AuthUser> users;

  @override
  List<Object?> get props => [users];
}

class InitialState extends DashboardState {
  const InitialState({super.users = const []});
}

class UpdatedState extends DashboardState {
  const UpdatedState({required super.users});
}
