part of 'users_cubit.dart';

abstract class UsersState extends Equatable {
  const UsersState({required this.users, this.selected});

  final List<AuthUser> users;
  final AuthUser? selected;

  @override
  List<Object?> get props => [users, selected];
}

class InitialState extends UsersState {
  const InitialState({super.users = const []});
}

class UpdatedState extends UsersState {
  const UpdatedState({required super.users, super.selected});
}
