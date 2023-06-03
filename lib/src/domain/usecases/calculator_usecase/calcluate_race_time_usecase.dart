import '../../repositories/calculator_repo.dart';

class CalculateRaceTimeUseCase {
  final RunningCalulator runningCalulator;

  const CalculateRaceTimeUseCase({required this.runningCalulator});

  call(Duration pace, double distanceInMeter) {
    return runningCalulator.calculateRace(pace, distanceInMeter);
  }
}
