import 'package:new_app/src/domain/entities/user_entity.dart';

import '../../repositories/calculator_repo.dart';

class SetRaceTimeUseCase {
  final RunningCalulator runningCalulator;

  SetRaceTimeUseCase({required this.runningCalulator});

  call(int houer, int minutes, int seconds) {
    return runningCalulator.setRaceTime(
        hours: houer, minutes: minutes, seconds: seconds);
  }
}
