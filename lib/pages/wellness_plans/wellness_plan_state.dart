part of 'wellness_plan_cubit.dart';

abstract class WellnessPlanState extends Equatable {
  const WellnessPlanState(this.plans);

  final List<WellnessPlan> plans;

  @override
  List<Object?> get props => [plans];
}

class InitialState extends WellnessPlanState {
  const InitialState() : super(const []);
}

class UpdatedState extends WellnessPlanState {
  const UpdatedState(super.plans);
}

class LoadingState extends WellnessPlanState {
  const LoadingState(super.plans);
}

class SuccessState extends WellnessPlanState {
  const SuccessState(super.plans);
}

class ErrorState extends WellnessPlanState {
  const ErrorState(super.plans, [this.message]);

  final String? message;

  @override
  List<Object?> get props => [message, super.props];
}
