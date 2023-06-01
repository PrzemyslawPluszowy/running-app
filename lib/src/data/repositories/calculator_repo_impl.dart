import 'package:new_app/src/data/constDB/estimated_race_result.dart';
import 'package:new_app/src/domain/entities/calcuate_entity.dart';
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
  CalcluateEntity setDistance({
    required double meters,
  }) {
    distanceInMeter = meters;
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
  int initCalculateVdot() {
    CalcluateEntity calc = CalcluateEntity(
        distance: distanceInMeter, pace: pace, timeRace: timeRace);
    final int vdot;
    if (calc.distance <= 5000) {
      final toSearchVdot = _calculateClosetValueToVdotTable(calc, 5000);
      vdot = searchVdot(toSearchVdot, '5k');
    } else if (calc.distance <= 10000) {
      final toSearchVdot = _calculateClosetValueToVdotTable(calc, 10000);
      vdot = searchVdot(toSearchVdot, '10k');
    } else if (calc.distance <= 22000) {
      final toSearchVdot = _calculateClosetValueToVdotTable(calc, 21099);
      vdot = searchVdot(toSearchVdot, 'hm');
    } else {
      final toSearchVdot = _calculateClosetValueToVdotTable(calc, 42195);
      vdot = searchVdot(toSearchVdot, 'm');
    }
    return vdot;
  }

  CalcluateEntity _calculateClosetValueToVdotTable(
      CalcluateEntity calc, double targetDistance) {
    int timeinSecond =
        ((targetDistance * calc.timeRace.inSeconds) / calc.distance).round();
    Duration timeRace = Duration(seconds: timeinSecond);
    Duration pace = calculatePace(calc.timeRace);
    print(pace);
    return CalcluateEntity(
        distance: targetDistance, pace: pace, timeRace: timeRace);
  }

  int searchVdot(CalcluateEntity calc, String distanceKey) {
    final List<int> timeTable =
        (estimatedRace.map((e) => e[distanceKey]!).toList());

    final closetTime = timeTable.reduce((a, b) =>
        (a - calc.timeRace.inSeconds).abs() <=
                (b - calc.timeRace.inSeconds).abs()
            ? a
            : b);

    int indexVdot = estimatedRace
        .indexWhere((element) => element[distanceKey] == closetTime);
    final vdot = estimatedRace[indexVdot]['vdot'];
    return vdot!;
  }

  @override
  CalcluateEntity getCurretResultRace() {
    return CalcluateEntity(
        distance: distanceInMeter, pace: pace, timeRace: timeRace);
  }
}
