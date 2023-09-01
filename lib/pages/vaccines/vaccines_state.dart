part of 'vaccines_cubit.dart';

abstract class VaccinesState extends Equatable {
  const VaccinesState(this.vaccines);

  final List<Plan> vaccines;

  @override
  List<Object?> get props => [vaccines];
}

class InitialState extends VaccinesState {
  const InitialState() : super(const []);
}

class UpdatedState extends VaccinesState {
  const UpdatedState(super.vaccines);
}

class LoadingState extends VaccinesState {
  const LoadingState(super.vaccines);
}

class SuccessState extends VaccinesState {
  const SuccessState(super.vaccines);
}

class ErrorState extends VaccinesState {
  const ErrorState(super.vaccines, [this.message]);

  final String? message;

  @override
  List<Object?> get props => [message, super.props];
}
