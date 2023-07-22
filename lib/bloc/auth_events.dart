part of 'auth_bloc.dart';

abstract class AuthEvents extends Equatable {
  const AuthEvents();

  @override
  List<Object?> get props => [];
}

class UpdateAuthState extends AuthEvents {
  const UpdateAuthState(this.user);

  final AuthUser? user;

  @override
  List<Object?> get props => [user];
}
