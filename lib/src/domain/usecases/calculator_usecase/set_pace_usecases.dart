import '../../repositories/calculator_repo.dart';

class SetPaceUseCase {
  final RunningCalulator runningCalulator;

  SetPaceUseCase({required this.runningCalulator});

  call(int houer, int minutes, int seconds) {
    return runningCalulator.setPaceTime(
        hours: houer, minutes: minutes, seconds: seconds);
  }
}
