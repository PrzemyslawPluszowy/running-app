part of 'list_race_calculated_cubit.dart';

abstract class ListRaceCalculatedState extends Equatable {
  const ListRaceCalculatedState();

  @override
  List<Object> get props => [];
}

class ListRaceCalculatedInitial extends ListRaceCalculatedState {
  @override
  List<Object> get props => [];
}

class ListRaceCalculatedLoading extends ListRaceCalculatedState {
  @override
  List<Object> get props => [];
}

class ListRaceCalculatedLoaded extends ListRaceCalculatedState {
  final List<CalcluateEntity> listUserRace;
  List<Object> get props => [listUserRace];

  const ListRaceCalculatedLoaded(this.listUserRace);
}

class DeltePostInit extends ListRaceCalculatedState {}

class DeltePostDone extends ListRaceCalculatedState {}
