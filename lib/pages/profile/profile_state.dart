part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState(this.user);

  final AuthUser? user;

  @override
  List<Object?> get props => [user];
}

class InitialState extends ProfileState {
  const InitialState() : super(null);
}

class UpdatedState extends ProfileState {
  const UpdatedState({required AuthUser? user}) : super(user);
}

class LoadingState extends ProfileState {
  const LoadingState({required AuthUser? user}) : super(user);
}

class SuccessState extends ProfileState {
  const SuccessState({
    required AuthUser? user,
    required this.type,
  }) : super(user);

  final ProfileChangeType type;

  @override
  List<Object?> get props => [type, super.props];
}

class ErrorState extends ProfileState {
  const ErrorState({
    required AuthUser? user,
    required this.message,
  }) : super(user);

  final String message;

  @override
  List<Object?> get props => [message, super.props];
}

enum ProfileChangeType { password, profile }
