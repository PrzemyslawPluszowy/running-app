import 'package:flutter/material.dart';

class CircleAvatarGlobalWidget extends StatelessWidget {
  const CircleAvatarGlobalWidget({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: 85,
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
            foregroundImage: NetworkImage(imageUrl),
          ),
        ),
      ),
    );
  }
}
