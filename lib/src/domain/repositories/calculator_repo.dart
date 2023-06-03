import 'package:new_app/src/domain/entities/calcuate_entity.dart';

abstract class RunningCalulator {
  Duration calculatePace(Duration timeRace, double distanceInmeter);
  Duration calculateRace(Duration pace, double distanceInMeter);
  int initCalculateVdot(CalcluateEntity calc);
}
