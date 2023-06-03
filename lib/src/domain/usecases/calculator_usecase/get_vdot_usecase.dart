import 'package:new_app/src/domain/repositories/calculator_repo.dart';

import '../../entities/calcuate_entity.dart';

class GetVdotUseCase {
  final RunningCalulator runningCalulator;

  const GetVdotUseCase({required this.runningCalulator});

  call(CalcluateEntity calc) {
    return runningCalulator.initCalculateVdot(calc);
  }
}
