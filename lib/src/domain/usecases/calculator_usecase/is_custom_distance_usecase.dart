import 'package:new_app/src/domain/repositories/calculator_repo.dart';

class IsCustomDistanceUseCase {
  final RunningCalulator runningCalulator;

  IsCustomDistanceUseCase({required this.runningCalulator});

  call(bool showCustomDistance) {
    return runningCalulator.showCustomDistanceField();
  }
}
