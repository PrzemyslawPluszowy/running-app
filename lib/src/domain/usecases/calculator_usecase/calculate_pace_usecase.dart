import 'package:new_app/src/domain/repositories/calculator_repo.dart';

class CalculatePaceUseCase {
  final RunningCalulator runningCalulator;

  const CalculatePaceUseCase({required this.runningCalulator});

  call(Duration timeRace, double distanceInmeter) {
    return runningCalulator.calculatePace(timeRace, distanceInmeter);
  }
}
