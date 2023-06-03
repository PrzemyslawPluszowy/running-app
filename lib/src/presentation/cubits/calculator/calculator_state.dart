part of 'calculator_cubit.dart';

abstract class CalculatorState extends Equatable {
  const CalculatorState();
}

class CalculatorInitial extends CalculatorState {
  final Duration timeRace = const Duration(hours: 0, minutes: 0, seconds: 0);
  final Duration pace = const Duration(hours: 0, minutes: 0, seconds: 0);
  final double distanceInMeter = 5000;

  @override
  List<Object> get props => [timeRace, pace, distanceInMeter];
}

class CalculatorController extends CalculatorState {
  const CalculatorController({
    required this.distanceInMeter,
    required this.timeRace,
    required this.pace,
  });

  final Duration timeRace;
  final Duration pace;
  final double distanceInMeter;

  @override
  List<Object> get props => [pace, timeRace, distanceInMeter];
}

class CalcResultSuccces extends CalculatorState {
  final CalcluateEntity resultRaceWithVdot;

  const CalcResultSuccces({required this.resultRaceWithVdot});

  @override
  List<Object?> get props => [resultRaceWithVdot];
}

class CalcResultError extends CalculatorState {
  final String error;

  const CalcResultError({required this.error});
  @override
  List<Object?> get props => [error];
}

class RaceSaving extends CalculatorState {
  @override
  List<Object?> get props => [];
}

class RaceSaved extends CalculatorState {
  @override
  List<Object?> get props => [];
}

class SaveRaceErr extends CalculatorState {
  @override
  List<Object?> get props => [];
}
