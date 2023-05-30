import 'package:new_app/src/domain/entities/calcuate_entity.dart';
import 'package:new_app/src/domain/entities/user_entity.dart';
import 'package:new_app/src/domain/repositories/calculator_repo.dart';

class RunningCalculatorImpl implements RunningCalulator {
  Duration timeRace = const Duration(hours: 0, minutes: 0, seconds: 0);
  Duration pace = const Duration(hours: 0, minutes: 0, seconds: 0);
  double distanceInMeter = 5000;

  @override
  Duration calculatePace(Duration timeRace) {
    return Duration(seconds: (timeRace.inSeconds ~/ (distanceInMeter / 1000)));
  }

  @override
  Duration calculateRace(Duration pace) {
    return Duration(
        seconds: (pace.inSeconds * (distanceInMeter / 1000)).toInt());
  }

  @override
  CalcluateEntity setDistance(
      {required double meters,
      String unit = 'm',
      bool customDistanceField = false}) {
    if (unit == 'm') {
      distanceInMeter = meters;
    } else if (unit == 'km') {
      distanceInMeter = double.parse((meters / 1000).toStringAsFixed(2));
    }
    pace = calculatePace(timeRace);
    return CalcluateEntity(
        distance: distanceInMeter, pace: pace, timeRace: timeRace);
  }

  @override
  CalcluateEntity setPaceTime(
      {int hours = 0, int minutes = 0, int seconds = 0}) {
    pace = Duration(hours: hours, minutes: minutes, seconds: seconds);
    timeRace = calculateRace(pace);
    return CalcluateEntity(
        distance: distanceInMeter, pace: pace, timeRace: timeRace);
  }

  @override
  CalcluateEntity setRaceTime(
      {int hours = 0, int minutes = 0, int seconds = 0}) {
    timeRace = Duration(hours: hours, minutes: minutes, seconds: seconds);
    pace = calculatePace(timeRace);
    return CalcluateEntity(
        distance: distanceInMeter, pace: pace, timeRace: timeRace);
  }

  @override
  CalcluateEntity showCustomDistanceField({bool isCustomdIstance = false}) {
    return CalcluateEntity(
        distance: distanceInMeter,
        pace: pace,
        timeRace: timeRace,
        isCustomDistanceField: isCustomdIstance);
  }
}
