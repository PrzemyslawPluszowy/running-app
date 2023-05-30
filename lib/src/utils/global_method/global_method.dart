import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> showDialogGlobal(
    {required BuildContext context,
    required String title,
    required String content}) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      actions: [
        TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('Ok'))
      ],
      title: Text(title),
      content: SizedBox(
        height: 300,
        width: 300,
        child: Center(
          child: Text(content),
        ),
      ),
    ),
  );
}

String durationToString(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  if (duration.inHours == 0) {
    return "$twoDigitMinutes : $twoDigitSeconds";
  } else {
    return "${twoDigits(duration.inHours)} : $twoDigitMinutes : $twoDigitSeconds";
  }
}
