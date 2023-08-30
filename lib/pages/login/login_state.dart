part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class InitialState extends LoginState {
  const InitialState();
}

class LoadingState extends LoginState {}

class SuccessState extends LoginState {}

class ErrorState extends LoginState {
  final String message;

  const ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
