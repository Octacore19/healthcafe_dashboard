part of 'users_cubit.dart';

abstract class UsersState extends Equatable {
  const UsersState({required this.users});

  final List<AuthUser> users;

  @override
  List<Object?> get props => [users];
}

class InitialState extends UsersState {
  const InitialState({super.users = const []});
}

class UpdatedState extends UsersState {
  const UpdatedState({required super.users});
}
