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
      child: SizedBox(
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
    );
  }
}
