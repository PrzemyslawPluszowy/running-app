import 'package:new_app/src/domain/entities/calcuate_entity.dart';
import 'package:new_app/src/domain/repositories/calculator_repo.dart';

class GetCurretCalcResultUsecase {
  final RunningCalulator runningCalulator;

  const GetCurretCalcResultUsecase({required this.runningCalulator});

  CalcluateEntity call() {
    return runningCalulator.getCurretResultRace();
  }
}
