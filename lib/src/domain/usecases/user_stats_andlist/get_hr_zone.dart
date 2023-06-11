class GetHrZoneUseCase {
  call({required int hrMin, required int hrMax}) {
    HrZone hrZone = HrZone(
        easyMin: hrMin,
        easyMax: (hrMin + 0.6 * (hrMax - hrMin)).toInt(),
        marathonMin: (hrMin + 0.6 * (hrMax - hrMin)).toInt(),
        marathonMax: (hrMin + 0.75 * (hrMax - hrMin)).toInt(),
        thresholdMin: (hrMin + 0.75 * (hrMax - hrMin)).toInt(),
        thresholdMax: (hrMin + 0.85 * (hrMax - hrMin)).toInt(),
        intervalMin: (hrMin + 0.85 * (hrMax - hrMin)).toInt(),
        intervalMax: (hrMin + 0.95 * (hrMax - hrMin)).toInt(),
        repMin: (hrMin + 0.95 * (hrMax - hrMin)).toInt(),
        repMax: hrMax);
    return hrZone;
  }
}

class HrZone {
  final int easyMin;
  final int easyMax;
  final int marathonMin;
  final int marathonMax;
  final int thresholdMin;
  final int thresholdMax;
  final int intervalMin;
  final int intervalMax;
  final int repMin;
  final int repMax;

  HrZone(
      {required this.easyMin,
      required this.easyMax,
      required this.marathonMin,
      required this.marathonMax,
      required this.thresholdMin,
      required this.thresholdMax,
      required this.intervalMin,
      required this.intervalMax,
      required this.repMin,
      required this.repMax});
}
