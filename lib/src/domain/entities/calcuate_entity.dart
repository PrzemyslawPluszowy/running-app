class CalcluateEntity {
  double distance;
  Duration pace;
  Duration timeRace;
  bool? isCustomDistanceField;

  CalcluateEntity({
    required this.distance,
    required this.pace,
    required this.timeRace,
    this.isCustomDistanceField = false,
  });
}
