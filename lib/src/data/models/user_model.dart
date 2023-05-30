import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_app/src/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String? uid;
  final String? userName;
  final String? email;
  final String? urlImageAvatar;
  final int? age;
  final int? weight;
  final int? height;
  final int? hrMax;
  final int? hrRest;
  final num? bmi;
  final num? vdot;
  final List? calc;

  const UserModel({
    this.uid,
    this.urlImageAvatar,
    this.userName,
    this.email,
    this.age,
    this.weight,
    this.height,
    this.hrMax,
    this.hrRest,
    this.bmi,
    this.vdot,
    this.calc,
  }) : super(
            age: age,
            bmi: bmi,
            uid: uid,
            calc: calc,
            email: email,
            height: height,
            hrMax: hrMax,
            hrRest: hrRest,
            urlImageAvatar: urlImageAvatar,
            userName: userName,
            vdot: vdot,
            weight: weight);

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        age: snapshot['age'],
        bmi: snapshot['bmi'],
        email: snapshot['email'],
        height: snapshot['height'],
        weight: snapshot['weight'],
        hrMax: snapshot['hrMax'],
        hrRest: snapshot['hrRest'],
        uid: snapshot['uid'],
        urlImageAvatar: snapshot['urlImageAvatar'],
        vdot: snapshot['vdot'],
        calc: List.from(snap.get('calc')),
        userName: snapshot['userName']);
  }
  Map<String, dynamic> toJson() => {
        'age': age,
        'bmi': bmi,
        'email': email,
        'height': height,
        'weight': weight,
        'hrMax': hrMax,
        'hrRest': hrRest,
        'uid': uid,
        'urlImageAvatar': urlImageAvatar,
        'vdot': vdot,
        'calc': calc,
        'userName': userName
      };
}
