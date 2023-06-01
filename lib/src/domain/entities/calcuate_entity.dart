import 'package:cloud_firestore/cloud_firestore.dart';

class CalcluateEntity {
  double distance;
  Duration pace;
  Duration timeRace;
  int? vdot;
  Timestamp? createdDate;

  CalcluateEntity({
    required this.distance,
    required this.pace,
    required this.timeRace,
    this.vdot,
    this.createdDate,
  });
}
