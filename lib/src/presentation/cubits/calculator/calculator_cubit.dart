import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_app/src/domain/usecases/calculator_usecase/get_curret_calc_result_usecase.dart';
import 'package:new_app/src/domain/usecases/calculator_usecase/get_vdot_usecase.dart';

import 'package:new_app/src/domain/usecases/calculator_usecase/set_distance_usecase.dart';
import 'package:new_app/src/domain/usecases/calculator_usecase/set_pace_usecases.dart';
import 'package:new_app/src/domain/usecases/calculator_usecase/set_race_time.dart';
import 'package:new_app/src/domain/usecases/save_calculated_race.dart';

import '../../../domain/entities/calcuate_entity.dart';

part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit(
      {required this.saveCalculatedRaceUsecase,
      required this.getCurretCalcResultUsecase,
      required this.getVdotUseCase,
      required this.setPaceUseCase,
      required this.setRaceTimeUseCase,
      required this.setDistanceUseCase})
      : super(CalculatorInitial());
  final SetPaceUseCase setPaceUseCase;
  final SetRaceTimeUseCase setRaceTimeUseCase;
  final SetDistanceUseCase setDistanceUseCase;
  final GetVdotUseCase getVdotUseCase;
  final GetCurretCalcResultUsecase getCurretCalcResultUsecase;
  final SaveCalculatedRaceUsecase saveCalculatedRaceUsecase;

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

  void setVdot() {
    int vdot = getVdotUseCase.call();
    final result = getCurretCalcResultUsecase.call();
    if (vdot > 70) {
      emit(const CalcResultError(
          error: 'Your result is too incredible to calc VDOT'));
    } else if (vdot < 30) {
      emit(const CalcResultError(
          error:
              'Your result is to low to calculate, maybe try method walk-run '));
    } else {
      result.vdot = vdot;
      emit(CalcResultSuccces(resultRaceWithVdot: result));
    }
  }

  Future<void> saveCalculatedRace(CalcluateEntity raceCalc) async {
    emit(RaceSaving());
    try {
      Future.delayed(const Duration(seconds: 5));

      await saveCalculatedRaceUsecase.call(raceCalc);
      emit(RaceSaved());
    } catch (e) {
      emit(SaveRaceErr());
    }
  }

  CalcluateEntity getInitValue() {
    return getCurretCalcResultUsecase.call();
  }
}
