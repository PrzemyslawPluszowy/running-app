import 'package:new_app/src/domain/entities/user_entity.dart';

abstract class FirebaseRepository {
  Future<void> registerUser(UserEntity user);
  Future<void> logIn(String email, String password);
  Future<void> logOut();
  Stream<String> isSign();
  Stream<List<UserEntity>> getCurretUser(String uid);
  Future<String> getCurrentUserUid();
  Future<void> registerUserAddFields(
      UserEntity user, String uid, String imageUrl);
}
