import 'package:new_app/src/domain/entities/user_entity.dart';

import '../entities/calcuate_entity.dart';

abstract class FirebaseRepository {
  Future<void> registerUser(UserEntity user);
  Future<void> logIn(String email, String password);
  Future<void> logOut();
  Stream<String> isSign();
  Stream<List<UserEntity>> getCurretUser(String uid);
  Future<String> getCurrentUserUid();
  Future<void> registerUserAddFields(
      UserEntity user, String uid, String imageUrl);
  Future<void> saveCalculatedRace(CalcluateEntity calc);
  Stream<List<CalcluateEntity>> getUserRaceList();
  Future<void> deleteUserSingleCalculation(String postId);
}
