import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_app/src/domain/usecases/calculator_usecase/calcluate_race_time_usecase.dart';
import 'package:new_app/src/domain/usecases/calculator_usecase/calculate_pace_usecase.dart';
import 'package:new_app/src/domain/usecases/calculator_usecase/get_vdot_usecase.dart';
import 'package:new_app/src/domain/usecases/calculator_usecase/save_calculated_race.dart';
import '../../../domain/entities/calcuate_entity.dart';
part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit({
    required this.calculatePaceUseCase,
    required this.calculateRaceTimeUseCase,
    required this.saveCalculatedRaceUsecase,
    required this.getVdotUseCase,
  }) : super(CalculatorInitial());

  final GetVdotUseCase getVdotUseCase;
  final SaveCalculatedRaceUsecase saveCalculatedRaceUsecase;
  final CalculatePaceUseCase calculatePaceUseCase;
  final CalculateRaceTimeUseCase calculateRaceTimeUseCase;

//init value to ui
  Duration timeRace = const Duration(hours: 0, minutes: 0, seconds: 0);
  Duration pace = const Duration(hours: 0, minutes: 0, seconds: 0);
  double distanceInMeter = 5000;

  void setingPaceTime({int hours = 0, int minutes = 0, int seconds = 0}) {
    pace = Duration(hours: hours, minutes: minutes, seconds: seconds);
    timeRace = calculateRaceTimeUseCase.call(pace, distanceInMeter);
    emit(CalculatorController(
        timeRace: timeRace, pace: pace, distanceInMeter: distanceInMeter));
  }

  void settingRaceTime({int hours = 0, int minutes = 0, int seconds = 0}) {
    timeRace = Duration(hours: hours, minutes: minutes, seconds: seconds);
    pace = calculatePaceUseCase.call(timeRace, distanceInMeter);
    emit(CalculatorController(
        timeRace: timeRace, pace: pace, distanceInMeter: distanceInMeter));
  }

  void settingDistance({
    required double meters,
  }) {
    distanceInMeter = meters;
    pace = calculatePaceUseCase.call(timeRace, distanceInMeter);
    emit(CalculatorController(
      timeRace: timeRace,
      pace: pace,
      distanceInMeter: distanceInMeter,
    ));
  }

  void setVdot() {
    final CalcluateEntity calc = CalcluateEntity(
        distance: distanceInMeter, pace: pace, timeRace: timeRace);
    int vdot = getVdotUseCase.call(calc);
    print(vdot);
    if (vdot > 85) {
      emit(const CalcResultError(
          error: 'Your result is too incredible to calc VDOT'));
    } else if (vdot < 30) {
      emit(const CalcResultError(
          error:
              'Your result is to low to calculate, maybe try method walk-run '));
    } else {
      calc.vdot = vdot;
      emit(CalcResultSuccces(resultRaceWithVdot: calc));
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
}
