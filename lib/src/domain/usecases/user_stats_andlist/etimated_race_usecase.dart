import 'package:new_app/src/core/constants/vdot_estimated_race_by_vdot.dart';

class EstimatedRaceTimeUseCase {
  call({required int vdot}) {
    int marathon = 0;
    int halfMarathon = 0;
    int tenKm = 0;
    int fiveKm = 0;
    int twoMile = 0;
    int oneMile = 0;
    int km15 = 0;
    int m1500m = 0;
    if (m42k.containsKey(vdot)) {
      marathon = m42k[vdot]!;
    }
    if (m21k.containsKey(vdot)) {
      halfMarathon = m21k[vdot]!;
    }
    if (m10k.containsKey(vdot)) {
      tenKm = m10k[vdot]!;
    }
    if (m5k.containsKey(vdot)) {
      fiveKm = m5k[vdot]!;
    }
    if (m3200.containsKey(vdot)) {
      twoMile = m3200[vdot]!;
    }
    if (m1600.containsKey(vdot)) {
      oneMile = m1600[vdot]!;
    }
    if (m1500.containsKey(vdot)) {
      m1500m = m1500[vdot]!;
    }
    if (m15k.containsKey(vdot)) {
      km15 = m15k[vdot]!;
    }
    return EsitamtedRaceTime(
        m1500: Duration(seconds: m1500m),
        m1600: Duration(seconds: oneMile),
        m3200: Duration(seconds: twoMile),
        m5k: Duration(seconds: fiveKm),
        m10k: Duration(seconds: tenKm),
        km15: Duration(seconds: km15),
        m21k: Duration(seconds: halfMarathon),
        m42k: Duration(seconds: marathon));
  }
}

class EsitamtedRaceTime {
  final Duration m1500;
  final Duration m1600;
  final Duration m3200;
  final Duration m5k;
  final Duration m10k;
  final Duration km15;
  final Duration m21k;
  final Duration m42k;

  EsitamtedRaceTime(
      {required this.km15,
      required this.m1500,
      required this.m1600,
      required this.m3200,
      required this.m5k,
      required this.m10k,
      required this.m21k,
      required this.m42k});
}
