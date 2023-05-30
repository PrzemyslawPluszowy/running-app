import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_app/src/domain/usecases/calculator_usecase/is_custom_distance_usecase.dart';

import 'package:new_app/src/domain/usecases/calculator_usecase/set_distance_usecase.dart';
import 'package:new_app/src/domain/usecases/calculator_usecase/set_pace_usecases.dart';
import 'package:new_app/src/domain/usecases/calculator_usecase/set_race_time.dart';

import '../../../domain/entities/calcuate_entity.dart';

part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit(
      {required this.isCustomDistanceUseCase,
      required this.setPaceUseCase,
      required this.setRaceTimeUseCase,
      required this.setDistanceUseCase})
      : super(CalculatorInitial());
  final SetPaceUseCase setPaceUseCase;
  final SetRaceTimeUseCase setRaceTimeUseCase;
  final SetDistanceUseCase setDistanceUseCase;
  final IsCustomDistanceUseCase isCustomDistanceUseCase;

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
        showCustomDistanceField: isCustomdIstance));
  }

  void setPaceTime({int hours = 0, int minutes = 0, int seconds = 0}) {
    CalcluateEntity race = setPaceUseCase.call(hours, minutes, seconds);
    emit(CalculatorController(timeRace: race.timeRace, pace: race.pace));
  }

  void showCustomDistanceField({bool isCustomdIstance = false}) {
    CalcluateEntity state = isCustomDistanceUseCase.call(isCustomdIstance);
    emit(CalculatorController(
        timeRace: state.timeRace,
        pace: state.pace,
        showCustomDistanceField: isCustomdIstance));
  }
}


// Duration timeRace = const Duration(hours: 0, minutes: 0, seconds: 0);
//   Duration pace = const Duration(hours: 0, minutes: 0, seconds: 0);
//   double distanceInMeter = 5000;

//   void setRaceTime({int hours = 0, int minutes = 0, int seconds = 0}) {
//     timeRace = Duration(hours: hours, minutes: minutes, seconds: seconds);
//     pace = calculatePace(timeRace);
//     emit(CalculatorSetDuration(timeRace: timeRace, pace: pace));
//   }

//   void setPaceTime({int hours = 0, int minutes = 0, int seconds = 0}) {
//     pace = Duration(hours: hours, minutes: minutes, seconds: seconds);
//     timeRace = calculateRace(pace);
//     emit(CalculatorSetDuration(timeRace: timeRace, pace: pace));
//   }



//   Duration calculatePace(Duration timeRace) {
//     return Duration(seconds: (timeRace.inSeconds ~/ (distanceInMeter / 1000)));
//   }

//   Duration calculateRace(Duration timeRace) {
//     return Duration(
//         seconds: (timeRace.inSeconds * (distanceInMeter / 1000)).toInt());
//   }
