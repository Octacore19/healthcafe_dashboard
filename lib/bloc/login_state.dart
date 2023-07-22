part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class InitailState extends LoginState {
  const InitailState();
}

class LoadingState extends LoginState {}

class SuccessState extends LoginState {}

class ErrorState extends LoginState {
  final String message;

  const ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
