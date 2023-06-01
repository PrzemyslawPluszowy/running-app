import 'package:new_app/src/domain/entities/calcuate_entity.dart';
import 'package:new_app/src/domain/repositories/calculator_repo.dart';

class GetVdotUseCase {
  final RunningCalulator runningCalulator;

  const GetVdotUseCase({required this.runningCalulator});

  call() {
    return runningCalulator.initCalculateVdot();
  }
}
