part of 'user_stats_cubit.dart';

abstract class UserStatsState extends Equatable {
  const UserStatsState();

  @override
  List<Object> get props => [];
}

class UserStatsInitial extends UserStatsState {}

class UserStatsLoading extends UserStatsState {}

class UserStatsLoaded extends UserStatsState {
  final List listOfvdot;

  const UserStatsLoaded({
    required this.listOfvdot,
  });
  @override
  List<Object> get props => [listOfvdot];
}
