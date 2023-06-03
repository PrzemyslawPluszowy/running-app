import 'package:flutter/material.dart';

import '../../../../domain/entities/user_entity.dart';
import '../../../widgets/avatar_circle_global_widget.dart';
import '../../../widgets/vdot_circle_widget.dart';

Container customAppBar(UserEntity loggedUser, BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primaryContainer,
    ),
    height: MediaQuery.of(context).size.height * 0.15,
    width: MediaQuery.of(context).size.width,
    child: Stack(
      children: [
        Container(
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(blurRadius: 4, blurStyle: BlurStyle.outer)
                ],
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 18, left: 10),
              child: Row(
                children: [
                  Text('Witaj  ',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.onPrimary)),
                  Text('${loggedUser.userName}  ',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.onPrimary)),
                ],
              ),
            )),
        Positioned(
          right: 10,
          bottom: 0,
          child: Container(
              width: 200,
              height: 104,
              child: Stack(children: [
                Stack(
                  clipBehavior: Clip.antiAlias,
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      top: 10,
                      right: 70,
                      child: VdotVircleWidget(
                        vdot: loggedUser.vdot,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: CircleAvatarGlobalWidget(
                        imageUrl: loggedUser.urlImageAvatar!,
                      ),
                    ),
                  ],
                ),
              ])),
        )
      ],
    ),
  );
}
