import 'package:new_app/src/core/constants/search_vdot_by_result.dart';
import 'package:new_app/src/domain/entities/calcuate_entity.dart';
import 'package:new_app/src/domain/repositories/calculator_repo.dart';

class RunningCalculatorImpl implements RunningCalulator {
  Duration timeRace = const Duration(hours: 0, minutes: 0, seconds: 0);
  Duration pace = const Duration(hours: 0, minutes: 0, seconds: 0);
  double distanceInMeter = 5000;

  @override
  Duration calculatePace(Duration timeRace, double distanceInMeter) {
    return Duration(seconds: (timeRace.inSeconds ~/ (distanceInMeter / 1000)));
  }

  @override
  Duration calculateRace(Duration pace, double distanceInMeter) {
    return Duration(
        seconds: (pace.inSeconds * (distanceInMeter / 1000)).toInt());
  }

  @override
  int initCalculateVdot(CalcluateEntity calc) {
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
    Duration pace = calculatePace(calc.timeRace, distanceInMeter);
    return CalcluateEntity(
        distance: targetDistance, pace: pace, timeRace: timeRace);
  }

  int searchVdot(CalcluateEntity calc, String distanceKey) {
    final List<int> timeTable =
        (vdotSearchTable.map((e) => e[distanceKey]!).toList());

    final closetTime = timeTable.reduce((a, b) =>
        (a - calc.timeRace.inSeconds).abs() <=
                (b - calc.timeRace.inSeconds).abs()
            ? a
            : b);

    int indexVdot = vdotSearchTable
        .indexWhere((element) => element[distanceKey] == closetTime);
    final vdot = vdotSearchTable[indexVdot]['vdot'];
    return vdot!;
  }
}
