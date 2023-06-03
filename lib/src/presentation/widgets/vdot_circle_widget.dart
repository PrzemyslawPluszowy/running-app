import 'package:flutter/material.dart';

class VdotVircleWidget extends StatelessWidget {
  const VdotVircleWidget({
    super.key,
    required this.vdot,
  });
  final num? vdot;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 90,
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 4, blurStyle: BlurStyle.normal)],
        gradient: LinearGradient(begin: Alignment(0.2, 2), colors: [
          Color.fromARGB(255, 242, 244, 242),
          Color.fromARGB(255, 229, 229, 234),
          Color.fromARGB(255, 255, 255, 255),
          Color.fromARGB(255, 109, 44, 239)
        ]),
        shape: BoxShape.circle,
      ),
      child: Padding(
        //this padding will be you border size
        padding: const EdgeInsets.all(7.0),
        child: Container(
          decoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Your ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'vdot ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                vdot != null
                    ? Text(
                        '$vdot',
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    : const Icon(Icons.question_mark),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
