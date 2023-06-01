import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app/src/domain/entities/calcuate_entity.dart';

class CalcluateModel extends CalcluateEntity {
  final double distance;
  final Duration pace;
  final Duration timeRace;
  int? vdot;
  final Timestamp dateCreated;

  CalcluateModel(
      {required this.dateCreated,
      required this.distance,
      required this.pace,
      required this.timeRace,
      this.vdot})
      : super(
            distance: distance,
            pace: pace,
            timeRace: timeRace,
            createdDate: dateCreated,
            vdot: vdot);

  factory CalcluateModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap as Map<String, dynamic>;
    return CalcluateModel(
        dateCreated: snapshot['dateCreated'],
        distance: snapshot['distance'],
        pace: snapshot['pace'],
        timeRace: snapshot['timeRace'],
        vdot: snapshot['vdot']);
  }
  Map<String, dynamic> toJson() => {
        'dateCreated': dateCreated,
        'distance': distance,
        'pace': pace,
        'timeRace': timeRace,
        'vdot': vdot
      };
}
