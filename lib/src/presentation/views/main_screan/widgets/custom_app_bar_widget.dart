import 'package:flutter/material.dart';

import '../../../../domain/entities/user_entity.dart';

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
                boxShadow: [
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
                      child: Container(
                        height: 90,
                        width: 90,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 4, blurStyle: BlurStyle.normal)
                          ],
                          gradient:
                              LinearGradient(begin: Alignment(0.2, 2), colors: [
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
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Your ',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  Text(
                                    'vdot ',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  loggedUser.vdot != null
                                      ? Text(
                                          loggedUser.height.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        )
                                      : const Icon(Icons.question_mark),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        height: 85,
                        width: 85,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 4, blurStyle: BlurStyle.normal)
                          ],
                          gradient:
                              LinearGradient(begin: Alignment(0.2, 2), colors: [
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
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              foregroundImage:
                                  NetworkImage(loggedUser.urlImageAvatar!),
                            ),
                          ),
                        ),
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
