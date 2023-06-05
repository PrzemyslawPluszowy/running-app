import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
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
  Stream<User?> isSign();
  Stream<List<UserEntity>> getCurretUser();
  Future<String> getCurrentUserUid();
  Future<String?> uploadAndGetUrlImage(File image);
  Future<void> saveCalculatedRace(CalcluateEntity calc);
  Stream<List<CalcluateEntity>> getUserRaceList();
  Future<void> deleteUserSingleCalculation(String postId);
  Stream<List<CalcluateEntity>> getAllUserList();
}
