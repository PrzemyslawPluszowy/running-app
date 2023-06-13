import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_app/src/domain/entities/user_entity.dart';

import '../entities/calcuate_entity.dart';

abstract class FirebaseRepository {
  Future<void> registerUser(UserEntity user);
  Future<String> logIn(String email, String password);
  Future<void> logOut();
  Stream<User?> isSign();
  Stream<List<UserEntity>> getCurretUser();

  Future<void> registerUserAddFields(
      UserEntity user, String uid, String imageUrl);
  Future<void> saveCalculatedRace(CalcluateEntity calc);
  Stream<List<CalcluateEntity>> getUserRaceList();
  Future<void> deleteUserSingleCalculation(String postId);
  getAllUsersCalcList();
  Future<List<CalcluateEntity>> getCurrentUserCalcList();
  Future<void> updateUserFields(UserEntity user);
  Future<String> forgotPassword(String email);
}
