import 'dart:ffi';
import 'dart:io';

import 'package:new_app/src/domain/entities/calcuate_entity.dart';

import '../../domain/entities/user_entity.dart';

abstract class RemoteDataSource {
  Future<void> registerUser(UserEntity user);
  Future<void> registerUserAddFields(
    UserEntity user,
    String uid,
  );

  Future<void> logIn(String email, String password);
  Future<void> logOut();
  Stream<String> isSign();
  Stream<List<UserEntity>> getCurretUser(String uid);
  Future<String> getCurrentUserUid();
  Future<String?> uploadAndGetUrlImage(File image);
  Future<void> saveCalculatedRace(CalcluateEntity calc);
  Stream<List<CalcluateEntity>> getUserRaceList();
  Future<void> deleteUserSingleCalculation(String postId);
}
