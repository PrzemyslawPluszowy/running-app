part of 'user_stats_cubit.dart';

abstract class UserStatsState extends Equatable {
  final int age;
  final int weight;
  final int height;
  final int hrMax;
  final int hrRest;
  final int bmi;
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
  final List<int> vdotList;

  const UserStatsState({
    this.vdotList = const [],
    this.m15km = Duration.zero,
    this.marathonTime = Duration.zero,
    this.halfMarathonTime = Duration.zero,
    this.tenKmTime = Duration.zero,
    this.fiveKmTime = Duration.zero,
    this.m3200 = Duration.zero,
    this.m1600 = Duration.zero,
    this.m1500 = Duration.zero,
    this.easyZoneMin = 0,
    this.easyZoneMax = 0,
    this.marathonZoneMin = 0,
    this.marathonZoneMax = 0,
    this.thresholdZoneMin = 0,
    this.thresholdZoneMax = 0,
    this.intervalZoneMin = 0,
    this.intervalZoneMax = 0,
    this.repetitionZoneMin = 0,
    this.repetitionZoneMax = 0,
    this.avgVdot = 0,
    this.age = 0,
    this.weight = 0,
    this.height = 0,
    this.hrMax = 0,
    this.hrRest = 0,
    this.bmi = 0,
    this.vdot = 0,
    this.name = '',
    this.distance = 0,
    this.easyPace = Duration.zero,
    this.thresholdPace = Duration.zero,
    this.intervalPace = Duration.zero,
    this.repetitionPace = Duration.zero,
    this.marathonPace = Duration.zero,
  });
  @override
  List<Object> get props => [
        vdotList,
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

class UserStatsInitial extends UserStatsState {
  const UserStatsInitial();
}

class UserStatsError extends UserStatsState {}

class UserStatsLoaded extends UserStatsState {
  const UserStatsLoaded({
    required this.vdotList,
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
    required this.marathonTime,
    required this.halfMarathonTime,
    required this.tenKmTime,
    required this.fiveKmTime,
    required this.m3200,
    required this.m1600,
    required this.m1500,
    required this.m15km,
    required this.avgVdot,
  }) : super(
            vdotList: vdotList,
            age: age,
            weight: weight,
            height: height,
            hrMax: hrMax,
            hrRest: hrRest,
            bmi: bmi,
            vdot: vdot,
            name: name,
            distance: distance,
            easyPace: easyPace,
            thresholdPace: thresholdPace,
            intervalPace: intervalPace,
            repetitionPace: repetitionPace,
            marathonPace: marathonPace,
            easyZoneMin: easyZoneMin,
            easyZoneMax: easyZoneMax,
            marathonZoneMin: marathonZoneMin,
            marathonZoneMax: marathonZoneMax,
            thresholdZoneMin: thresholdZoneMin,
            thresholdZoneMax: thresholdZoneMax,
            intervalZoneMin: intervalZoneMin,
            intervalZoneMax: intervalZoneMax,
            repetitionZoneMin: repetitionZoneMin,
            repetitionZoneMax: repetitionZoneMax,
            marathonTime: marathonTime,
            halfMarathonTime: halfMarathonTime,
            tenKmTime: tenKmTime,
            fiveKmTime: fiveKmTime,
            m3200: m3200,
            m1600: m1600,
            m1500: m1500,
            m15km: m15km,
            avgVdot: avgVdot);
  final int age;
  final int weight;
  final int height;
  final int hrMax;
  final int hrRest;
  final int bmi;
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
  //estimated race time
  final Duration marathonTime;
  final Duration halfMarathonTime;
  final Duration m15km;
  final Duration tenKmTime;
  final Duration fiveKmTime;
  final Duration m3200;
  final Duration m1600;
  final Duration m1500;

  final List<int> vdotList;
}
