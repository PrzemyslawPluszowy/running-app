import '../../domain/entities/vdot_pace_entity.dart';

class VdotTraningPaceModel {
  final int vdot;
  final int distance;
  final int easyPace;
  final int thresholdPace;
  final int intervalPace;
  final int repetitionPace;
  final int marathonPace;

  VdotTraningPaceModel(
      {required this.vdot,
      required this.distance,
      required this.easyPace,
      required this.marathonPace,
      required this.thresholdPace,
      required this.intervalPace,
      required this.repetitionPace});

  factory VdotTraningPaceModel.fromJson(Map<String, dynamic> json) {
    return VdotTraningPaceModel(
        distance: json["distance"],
        vdot: json["vdot"],
        easyPace: json["easyPace"],
        thresholdPace: json["thresholdPace"],
        intervalPace: json["intervalPace"],
        repetitionPace: json["repetitionPace"],
        marathonPace: json["marathonPace"]);
  }

  VdotTraningPaceEntity toEntity() {
    return VdotTraningPaceEntity(
        vdot: vdot,
        distance: distance,
        easyPace: Duration(seconds: easyPace),
        thresholdPace: Duration(seconds: thresholdPace),
        intervalPace: Duration(seconds: intervalPace),
        repetitionPace: Duration(seconds: repetitionPace),
        marathonPace: Duration(seconds: marathonPace));
  }
}
