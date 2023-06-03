import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

extension TimestampParase on Timestamp {
  String dateToString() {
    return DateFormat.yMMMMEEEEd().format(this.toDate()).toString();
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
