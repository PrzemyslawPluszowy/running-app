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
  final bool showCustomDistanceField;

  @override
  List<Object> get props => [pace, timeRace, showCustomDistanceField];

  const CalculatorController({
    this.showCustomDistanceField = false,
    required this.timeRace,
    required this.pace,
  });
}
