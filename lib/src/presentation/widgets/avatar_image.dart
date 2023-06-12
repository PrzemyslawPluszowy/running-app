import 'dart:io';

import 'package:flutter/material.dart';

class AvatarImage extends StatelessWidget {
  const AvatarImage({
    super.key,
    required this.colorScheme,
    required this.image,
  });

  final ColorScheme colorScheme;
  final File image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(alignment: Alignment.center, children: [
        SizedBox(
            height: 165,
            width: 165,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: Container(
                color: Color.fromARGB(125, 152, 7, 255),
              ),
            )),
        SizedBox(
          height: 140,
          width: 140,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(90),
            child: Container(
                decoration: BoxDecoration(
                    color: colorScheme.primary,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 20,
                          color: colorScheme.onBackground,
                          spreadRadius: 2,
                          offset: const Offset(2, 2))
                    ],
                    borderRadius: BorderRadius.circular(90)),
                child: Image.file(
                  image,
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ]),
    );
  }
}
