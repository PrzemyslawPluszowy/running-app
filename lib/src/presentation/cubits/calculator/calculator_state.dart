part of 'calculator_cubit.dart';

abstract class CalculatorState extends Equatable {
  const CalculatorState();
}

class CalculatorInitial extends CalculatorState {
  @override
  List<Object> get props => [];
}

class CalculatorController extends CalculatorState {
  const CalculatorController({
    required this.timeRace,
    required this.pace,
  });
  final Duration timeRace;
  final Duration pace;

  @override
  List<Object> get props => [
        pace,
        timeRace,
      ];
}

class CalcResultSuccces extends CalculatorState {
  final CalcluateEntity resultRaceWithVdot;

  const CalcResultSuccces({required this.resultRaceWithVdot});

  List<Object?> get props => [resultRaceWithVdot];
}

class CalcResultError extends CalculatorState {
  final String error;

  const CalcResultError({required this.error});
  List<Object?> get props => [error];
}
