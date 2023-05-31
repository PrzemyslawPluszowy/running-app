part of 'calculator_cubit.dart';

abstract class CalculatorState extends Equatable {
  const CalculatorState();
}

class CalculatorInitial extends CalculatorState {
  @override
  List<Object> get props => [];
}

class CalculatorController extends CalculatorState {
  final Duration timeRace;
  final Duration pace;

  @override
  List<Object> get props => [
        pace,
        timeRace,
      ];

  const CalculatorController({
    required this.timeRace,
    required this.pace,
  });
}
