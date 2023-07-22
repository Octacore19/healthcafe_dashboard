part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState(this.user);

  final AuthUser? user;

  @override
  List<Object?> get props => [user];
}

class AuthUnknownState extends AuthState {
  const AuthUnknownState() : super(null);
}

class AuthenticatedState extends AuthState {
  const AuthenticatedState(super.user);
}

class UnauthenticatedState extends AuthState {
  const UnauthenticatedState() : super(null);
}
