import 'package:new_app/src/data/datasources/remote_data_source.dart';
import 'package:new_app/src/domain/entities/user_entity.dart';
import 'package:new_app/src/domain/repositories/firebase_repository.dart';

class FirebaseRepoImpl implements FirebaseRepository {
  final RemoteDataSource remoteDataSource;

  FirebaseRepoImpl({required this.remoteDataSource});
  @override
  Future<String> getCurrentUserUid() {
    // TODO: implement getCurrentUserUid
    throw UnimplementedError();
  }

  @override
  Stream<List<UserEntity>> getCurretUser(String uid) {
    return remoteDataSource.getCurretUser(uid);
  }

  @override
  Stream<String> isSign() {
    return remoteDataSource.isSign();
  }

  @override
  Future<void> logOut() {
    return remoteDataSource.logOut();
  }

  @override
  Future<void> registerUser(UserEntity user) async {
    return remoteDataSource.registerUser(user);
  }

  @override
  Future<void> registerUserAddFields(
      UserEntity user, String uid, String imageUrl) {
    return remoteDataSource.registerUserAddFields(
      user,
      uid,
    );
  }

  @override
  Future<void> logIn(String email, String password) {
    return remoteDataSource.logIn(email, password);
  }
}
