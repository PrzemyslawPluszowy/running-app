import 'package:cloud_firestore/cloud_firestore.dart';

class CalcluateEntity {
  String? id;
  String? creatorUid;
  String? avatarUrl;
  String? userName;
  Timestamp? createdDate;
  int? vdot;

  final double distance;
  final Duration pace;
  final Duration timeRace;

  CalcluateEntity({
    this.avatarUrl,
    this.userName,
    this.creatorUid,
    required this.distance,
    required this.pace,
    required this.timeRace,
    this.vdot,
    this.createdDate,
  });
}
