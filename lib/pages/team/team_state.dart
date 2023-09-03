part of 'team_cubit.dart';

abstract class TeamState extends Equatable {
  const TeamState();

  @override
  List<Object?> get props => [];
}

class InitialState extends TeamState {}

class LoadedState extends TeamState {}
