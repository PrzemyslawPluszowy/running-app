import 'dart:io';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? userName;
  final String? email;
  final String? password;
  final String? urlImageAvatar;
  final int? age;
  final int? weight;
  final int? height;
  final int? hrMax;
  final int? hrRest;
  final num? bmi;
  final num? vdot;
  final List? calc;
  final File? imagefile;

  const UserEntity(
      {this.uid,
      this.userName,
      this.email,
      this.password,
      this.urlImageAvatar,
      this.age,
      this.weight,
      this.height,
      this.hrMax,
      this.hrRest,
      this.bmi,
      this.vdot,
      this.calc,
      this.imagefile});

  @override
  List<Object?> get props => [
        uid,
        userName,
        email,
        age,
        weight,
        height,
        hrMax,
        hrRest,
        bmi,
        vdot,
        calc,
        imagefile,
        urlImageAvatar,
        password
      ];
}
