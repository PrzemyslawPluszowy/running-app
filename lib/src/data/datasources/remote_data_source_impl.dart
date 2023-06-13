import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_app/src/data/datasources/remote_data_source.dart';
import 'package:new_app/src/data/datasources/static_data_impl.dart';
import 'package:new_app/src/data/models/calculate_model.dart';
import 'package:new_app/src/data/models/user_model.dart';
import 'package:new_app/src/domain/entities/calcuate_entity.dart';
import 'package:new_app/src/domain/entities/user_entity.dart';
import 'package:uuid/uuid.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  RemoteDataSourceImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
    required this.firebaseStorage,
  });

  @override
  Future<String> getCurrentUserUid() async {
    String uid = firebaseAuth.currentUser!.uid;
    return uid;
  }

  @override
  Stream<List<UserEntity>> getCurretUser() async* {
    var curretuid = await getCurrentUserUid();
    final user = firebaseFirestore
        .collection('users')
        .where('uid', isEqualTo: curretuid)
        .limit(1);

    yield* user.snapshots().map((querySnap) =>
        querySnap.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<User?> isSign() async* {
    yield* firebaseAuth.authStateChanges();
  }

  @override
  Future<void> logOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<void> registerUser(UserEntity user) async {
    if (user.userName == null || user.userName!.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Input correct name',
      );
      return;
    }
    if (user.age == null) {
      Fluttertoast.showToast(msg: 'Age is must be provided');
      return;
    }
    if (user.weight == null) {
      Fluttertoast.showToast(msg: 'Weight is must be provided');
      return;
    }
    if (user.height == null) {
      Fluttertoast.showToast(msg: 'Height is must be provided');
      return;
    }

    try {
      if (user.email != null && user.password != null) {
        final credential = await firebaseAuth.createUserWithEmailAndPassword(
            email: user.email!, password: user.password!);

        if (credential.user?.uid != null) {
          await registerUserAddFields(user, credential.user!.uid);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
      } else {
        Fluttertoast.showToast(
            backgroundColor: Colors.deepPurpleAccent, msg: e.code.toString());
      }
    } catch (e) {
      Fluttertoast.showToast(
          backgroundColor: Colors.deepPurpleAccent, msg: e.toString());
    }
  }

  @override
  Future<void> registerUserAddFields(UserEntity user, String uid) async {
    String? imageUrl = await uploadAndGetUrlImage(user.imagefile!);

    final newUser = UserModel(
        urlImageAvatar: imageUrl,
        calc: const [],
        uid: uid,
        age: user.age,
        bmi: StaticDataImpl()
            .calculateBmi(weight: user.weight!, height: user.height!),
        email: user.email,
        weight: user.weight,
        userName: user.userName,
        height: user.height,
        hrMax:
            user.hrMax ?? StaticDataImpl().calculateSimpleHrmax(age: user.age!),
        hrRest: user.hrMax ?? 60);
    try {
      if (firebaseAuth.currentUser != null) {
        await firebaseFirestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .set(newUser.toJson())
            .whenComplete(() {
          Fluttertoast.showToast(msg: 'Account Created');
        });
      }
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.code);
    }
  }

  @override
  Future<String> uploadAndGetUrlImage(File image) async {
    String userUid = await getCurrentUserUid();
    final Reference ref =
        firebaseStorage.ref('usersAvatar').child(userUid).child(userUid);
    TaskSnapshot uploadTask = await ref.putFile(image).whenComplete(() {});
    return uploadTask.ref.getDownloadURL();
  }

  @override
  Future<String> logIn(String email, String password) async {
    String res = '';
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      res = 'success';
    } on FirebaseAuthException catch (e) {
      {
        res = e.code;
        Fluttertoast.showToast(msg: e.code);
      }
    } catch (e) {
      {
        res = e.toString();
        Fluttertoast.showToast(msg: e.toString());
      }
    }
    return res;
  }

  @override
  Future<void> saveCalculatedRace(CalcluateEntity calc) async {
    String id = const Uuid().v1();
    try {
      String userUid = await getCurrentUserUid();
      CalcluateModel newCalc = CalcluateModel(
          vdot: calc.vdot,
          dateCreated: calc.createdDate ?? Timestamp.now(),
          distance: calc.distance,
          paceInSecond: calc.pace.inSeconds,
          timeInSecond: calc.timeRace.inSeconds,
          id: id,
          creatorUid: userUid,
          userName: calc.userName ?? 'Unknow User',
          avatarUrl: calc.avatarUrl);

      await firebaseFirestore
          .collection('calculatedRace')
          .doc(newCalc.id)
          .set(newCalc.toJson());

      updateVdot(newCalc.vdot);
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.code);
    } catch (e) {
      {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  Future<void> updateVdot(int? vdot) async {
    String userUid = await getCurrentUserUid();

    if (vdot != null) {
      await firebaseFirestore
          .collection('users')
          .doc(userUid)
          .update({'vdot': vdot});
    }
  }

  @override
  Future<void> deleteUserSingleCalculation(String postId) async {
    try {
      await firebaseFirestore.collection('calculatedRace').doc(postId).delete();
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.code);
    }
  }

  @override
  Stream<List<CalcluateEntity>> getAllUserList() async* {
    final ref = firebaseFirestore
        .collection('calculatedRace')
        .orderBy(
          'dateCreated',
          descending: true,
        )
        .limit(15);

    final list = ref.snapshots().map((event) =>
        event.docs.map((e) => CalcluateModel.fromSnapshot(e)).toList());
    yield* list;
  }

  @override
  Stream<List<CalcluateEntity>> getUserRaceList() async* {
    try {
      var userUid = await getCurrentUserUid();

      final ref = firebaseFirestore
          .collection('calculatedRace')
          .where(
            'creatorUid',
            isEqualTo: userUid,
          )
          .orderBy('dateCreated', descending: true)
          .limit(15);

      final list = ref.snapshots().map((calc) =>
          calc.docs.map((e) => CalcluateModel.fromSnapshot(e)).toList());

      yield* list;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Future<List<CalcluateEntity>> getCurrentUserCalcList() async {
    List<CalcluateEntity> list = [];
    try {
      var userUid = await getCurrentUserUid();

      final ref = await firebaseFirestore
          .collection('calculatedRace')
          .where('creatorUid', isEqualTo: userUid)
          .get()
          .then((value) =>
              value.docs.map((e) => CalcluateModel.fromSnapshot(e)).toList());
      list = ref;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return list;
  }

  @override
  Future<void> updateUserFields(UserEntity user) async {
    Map<String, dynamic> userData = Map();
    if (user.age != null && user.age != 0) {
      userData['age'] = user.age;
    }
    if (user.weight != null && user.weight != 0) {
      userData['weight'] = user.weight;
    }
    if (user.height != null && user.height != 0) {
      userData['height'] = user.height;
    }
    if (user.userName != null && user.userName != '') {
      userData['userName'] = user.userName;
    }
    if (user.imagefile != null) {
      String? imageUrl = await uploadAndGetUrlImage(user.imagefile!);
      userData['urlImageAvatar'] = imageUrl;
    }
    if (user.hrMax != null && user.hrMax != 0) {
      userData['hrMax'] = user.hrMax;
    }
    if (user.hrRest != null && user.hrRest != 0) {
      userData['hrRest'] = user.hrRest;
    }
    if (user.bmi != null && user.bmi != 0) {
      userData['bmi'] = user.bmi;
    }
    try {
      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .update(userData);
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.code);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Future<String> forgotPassword(String email) async {
    String res = '';
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      res = 'success';
    } on FirebaseException catch (e) {
      // Fluttertoast.showToast(msg: e.code);
      res = e.code;
    } catch (e) {
      // Fluttertoast.showToast(msg: e.toString());
      res = e.toString();
    }
    return res;
  }
}
