part of 'assessment_cubit.dart';

abstract class AssessmentState extends Equatable {
  const AssessmentState(this.assessments);

  final List<Assessment> assessments;

  @override
  List<Object?> get props => [assessments];
}

class InitialState extends AssessmentState {
  InitialState() : super(List.empty());
}

class LoadedState extends AssessmentState {
  const LoadedState(super.assessments);
}

class LoadingState extends AssessmentState {
  const LoadingState(super.assessments);
}

class SuccessState extends AssessmentState {
  const SuccessState(super.assessments);
}

class ErrorState extends AssessmentState {
  const ErrorState(super.assessments, this.message);

  final String message;

  @override
  List<Object?> get props => [message, super.props];
}
