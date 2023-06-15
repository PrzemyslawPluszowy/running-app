import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

extension TimestampParase on Timestamp {
  String dateToString() {
    return DateFormat.yMMMEd().format(this.toDate()).toString();
  }
}

extension DurationParase on Duration {
  String toStoper() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(this.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(this.inSeconds.remainder(60));
    if (this.inHours == 0) {
      return "$twoDigitMinutes:$twoDigitSeconds";
    } else {
      return "${twoDigits(this.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }
  }
}

extension Scale on double {
  scaleToRange(
      {required double targetScaleMin,
      required double targetScaleMax,
      required double inputScaleMin,
      required double inputScaleMax,
      required double input}) {
    return (((targetScaleMax - targetScaleMin) *
            ((input - inputScaleMin) / (inputScaleMax - inputScaleMin))) +
        targetScaleMin);
  }
}

extension AvgValue on List<int> {
  double avgFromInt() {
    if (this.isEmpty) {
      return 0;
    } else {
      int sum = this.reduce((a, b) => a + b);
      return sum / this.length;
    }
  }
}

extension ToPace on Duration {
  Duration toPace(int distance) {
    if (distance <= 0) {
      return Duration(seconds: 0);
    }
    if (this.inSeconds <= 0) {
      return Duration(seconds: 0);
    } else {
      return Duration(seconds: (this.inSeconds ~/ (distance / 1000)));
    }
  }
}
