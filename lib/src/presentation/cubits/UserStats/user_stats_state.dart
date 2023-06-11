part of 'user_stats_cubit.dart';

abstract class UserStatsState extends Equatable {
  const UserStatsState();

  @override
  List<Object> get props => [];
}

class UserStatsInitial extends UserStatsState {}

class UserStatsLoaded extends UserStatsState {
  final int age;
  final int weight;
  final int height;
  final int hrMax;
  final int hrRest;
  final double bmi;
  final int vdot;
  final String name;
  final double avgVdot;
  //traning pace
  final int distance;
  final Duration easyPace;
  final Duration thresholdPace;
  final Duration intervalPace;
  final Duration repetitionPace;
  final Duration marathonPace;

  //hr zone
  final int easyZoneMin;
  final int easyZoneMax;
  final int marathonZoneMin;
  final int marathonZoneMax;
  final int thresholdZoneMin;
  final int thresholdZoneMax;
  final int intervalZoneMin;
  final int intervalZoneMax;
  final int repetitionZoneMin;
  final int repetitionZoneMax;
  //estimated time race
  final Duration marathonTime;
  final Duration halfMarathonTime;
  final Duration tenKmTime;
  final Duration fiveKmTime;
  final Duration m3200;
  final Duration m1600;
  final Duration m1500;
  final Duration m15km;

  const UserStatsLoaded({
    required this.m15km,
    required this.marathonTime,
    required this.halfMarathonTime,
    required this.tenKmTime,
    required this.fiveKmTime,
    required this.m3200,
    required this.m1600,
    required this.m1500,
    required this.easyZoneMin,
    required this.easyZoneMax,
    required this.marathonZoneMin,
    required this.marathonZoneMax,
    required this.thresholdZoneMin,
    required this.thresholdZoneMax,
    required this.intervalZoneMin,
    required this.intervalZoneMax,
    required this.repetitionZoneMin,
    required this.repetitionZoneMax,
    required this.avgVdot,
    required this.age,
    required this.weight,
    required this.height,
    required this.hrMax,
    required this.hrRest,
    required this.bmi,
    required this.vdot,
    required this.name,
    required this.distance,
    required this.easyPace,
    required this.thresholdPace,
    required this.intervalPace,
    required this.repetitionPace,
    required this.marathonPace,
  });

  @override
  List<Object> get props => [
        age,
        weight,
        height,
        hrMax,
        hrRest,
        bmi,
        vdot,
        name,
        distance,
        easyPace,
        thresholdPace,
        intervalPace,
        repetitionPace,
        marathonPace,
        easyZoneMin,
        easyZoneMax,
        marathonZoneMin,
        marathonZoneMax,
        thresholdZoneMin,
        thresholdZoneMax,
        intervalZoneMin,
        intervalZoneMax,
        repetitionZoneMin,
        repetitionZoneMax,
        avgVdot,
        marathonTime,
        halfMarathonTime,
        tenKmTime,
        fiveKmTime,
        m3200,
        m1600,
        m1500,
        m15km,
      ];
}
