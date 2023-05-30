import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_app/src/data/datasources/remote_data_source.dart';
import 'package:new_app/src/data/datasources/static_data_impl.dart';
import 'package:new_app/src/data/models/user_model.dart';
import 'package:new_app/src/domain/entities/user_entity.dart';

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
  Stream<List<UserEntity>> getCurretUser(String uid) {
    final user = firebaseFirestore
        .collection('users')
        .where('uid', isEqualTo: uid)
        .limit(1);

    return user.snapshots().map((querySnap) =>
        querySnap.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<String> isSign() async* {
    StreamController<String> userUid = StreamController<String>();
    firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        return;
      } else {
        userUid.add(user.uid);
      }
    });
    yield* userUid.stream;
  }

  @override
  Future<void> logOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<void> registerUser(UserEntity user) async {
    if (user.userName == null || user.userName!.isEmpty) {
      Fluttertoast.showToast(msg: 'Input correct name');
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
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
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
  Future<void> logIn(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print('login');
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }
}
