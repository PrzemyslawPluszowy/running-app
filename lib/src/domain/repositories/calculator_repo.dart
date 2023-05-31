import 'package:new_app/src/domain/entities/calcuate_entity.dart';

abstract class RunningCalulator {
  CalcluateEntity setRaceTime(
      {int hours = 0, int minutes = 0, int seconds = 0});

  CalcluateEntity setPaceTime(
      {int hours = 0, int minutes = 0, int seconds = 0});

  CalcluateEntity setDistance({required double meters});

  Duration calculatePace(Duration timeRace);
  Duration calculateRace(Duration timeRace);
}
