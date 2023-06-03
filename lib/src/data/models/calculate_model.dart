import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app/src/domain/entities/calcuate_entity.dart';

class CalcluateModel extends CalcluateEntity {
  final String creatorUid;
  final Timestamp dateCreated;

  final String id;
  final String userName;
  final double distance;
  final int paceInSecond;
  final int timeInSecond;
  int? vdot;
  String? avatarUrl;

  CalcluateModel(
      {required this.userName,
      required this.creatorUid,
      required this.id,
      required this.dateCreated,
      required this.distance,
      required this.paceInSecond,
      required this.timeInSecond,
      this.vdot,
      this.avatarUrl})
      : super(
            avatarUrl: avatarUrl,
            userName: userName,
            creatorUid: creatorUid,
            distance: distance,
            pace: Duration(seconds: paceInSecond),
            timeRace: Duration(seconds: timeInSecond),
            createdDate: dateCreated,
            vdot: vdot);

  factory CalcluateModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return CalcluateModel(
        dateCreated: snapshot['dateCreated'],
        distance: snapshot['distance'],
        paceInSecond: snapshot['paceInSecond'],
        timeInSecond: snapshot['timeInSecond'],
        vdot: snapshot['vdot'],
        id: snapshot['id'],
        creatorUid: snapshot['creatorUid'],
        userName: snapshot['userName'],
        avatarUrl: snapshot['avatarUrl']);
  }
  Map<String, dynamic> toJson() => {
        'dateCreated': dateCreated,
        'creatorUid': creatorUid,
        'userName': userName,
        'distance': distance,
        'paceInSecond': paceInSecond,
        'timeInSecond': timeInSecond,
        'vdot': vdot,
        'id': id,
        'avatarUrl': avatarUrl
      };
}
