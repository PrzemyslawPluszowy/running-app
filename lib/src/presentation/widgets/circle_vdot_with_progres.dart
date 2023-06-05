import 'package:flutter/material.dart';
import 'package:new_app/src/core/ext/extension.dart';

class CircleProgrssWidget extends StatelessWidget {
  const CircleProgrssWidget({
    Key? key,
    required this.value,
    required this.maxValue,
    required this.minValue,
    this.title,
    this.subtitle,
  }) : super(key: key);
  final double? value;
  final double maxValue;
  final double minValue;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 90,
        height: 90,
        child: CustomPaint(
          foregroundPainter: CircleProgress(
              angle: value != null
                  ? value!.scaleToRange(
                      targetScaleMin: 2,
                      targetScaleMax: 7,
                      inputScaleMin: minValue,
                      inputScaleMax: maxValue,
                      input: value!,
                    )
                  : 0),
          child: Container(
            height: 90,
            width: 90,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(blurRadius: 4, blurStyle: BlurStyle.normal)
              ],
              gradient: SweepGradient(
                  stops: [0.1, 0.3, 0.5, 0.7],
                  transform: GradientRotation(1.5),
                  colors: [
                    Color.fromARGB(255, 0, 115, 255),
                    Color.fromARGB(255, 0, 255, 30),
                    Color.fromARGB(255, 255, 247, 0),
                    Color.fromARGB(255, 239, 44, 44)
                  ]),
              shape: BoxShape.circle,
            ),
            child: Padding(
              //this padding will be you border size
              padding: const EdgeInsets.all(7.0),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      title != null
                          ? Text(
                              title!,
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                          : const SizedBox(),
                      subtitle != null
                          ? Text(
                              subtitle!,
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                          : const SizedBox(),
                      value != null
                          ? Text(
                              '$value',
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          : const Icon(Icons.question_mark),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class CircleProgress extends CustomPainter {
  CircleProgress({
    required this.angle,
  });

  final double angle;
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    Paint pointerPaint = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center2 = Offset(size.width / 2, size.height / 2);
    double radius2 = 45;
    canvas.drawArc(Rect.fromCircle(center: center2, radius: radius2), angle,
        0.1, false, pointerPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
