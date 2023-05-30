import 'package:new_app/src/domain/repositories/calculator_repo.dart';

class SetDistanceUseCase {
  final RunningCalulator runningCalulator;

  SetDistanceUseCase({required this.runningCalulator});

  call(double meters) {
    return runningCalulator.setDistance(meters: meters);
  }
}
