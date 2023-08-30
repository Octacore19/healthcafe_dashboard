part of 'user_profile_cubit.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState({
    required this.user,
    required this.appointments,
  });

  final AuthUser? user;
  final List<Appointment> appointments;

  @override
  List<Object?> get props => [user, appointments];
}

class InitialState extends UserProfileState {
  const InitialState({super.appointments = const [], super.user});
}

class UpdatedState extends UserProfileState {
  const UpdatedState({
    required super.user,
    required super.appointments,
  });
}
