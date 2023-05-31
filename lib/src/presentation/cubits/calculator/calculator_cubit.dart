import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:new_app/src/domain/usecases/calculator_usecase/set_distance_usecase.dart';
import 'package:new_app/src/domain/usecases/calculator_usecase/set_pace_usecases.dart';
import 'package:new_app/src/domain/usecases/calculator_usecase/set_race_time.dart';

import '../../../domain/entities/calcuate_entity.dart';

part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit(
      {required this.setPaceUseCase,
      required this.setRaceTimeUseCase,
      required this.setDistanceUseCase})
      : super(CalculatorInitial());
  final SetPaceUseCase setPaceUseCase;
  final SetRaceTimeUseCase setRaceTimeUseCase;
  final SetDistanceUseCase setDistanceUseCase;

  void setRaceTime({int hours = 0, int minutes = 0, int seconds = 0}) {
    CalcluateEntity race = setRaceTimeUseCase.call(hours, minutes, seconds);
    emit(CalculatorController(timeRace: race.timeRace, pace: race.pace));
  }

  void setDistance({
    bool isCustomdIstance = false,
    required double meters,
    String unit = 'm',
  }) {
    CalcluateEntity calcluateEntity = setDistanceUseCase.call(meters);
    emit(CalculatorController(
      timeRace: calcluateEntity.timeRace,
      pace: calcluateEntity.pace,
    ));
  }

  void setPaceTime({int hours = 0, int minutes = 0, int seconds = 0}) {
    CalcluateEntity race = setPaceUseCase.call(hours, minutes, seconds);
    emit(CalculatorController(timeRace: race.timeRace, pace: race.pace));
  }
}
