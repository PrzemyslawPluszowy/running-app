import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_app/src/data/datasources/remote_data_source.dart';
import 'package:new_app/src/domain/entities/calcuate_entity.dart';
import 'package:new_app/src/domain/entities/user_entity.dart';
import 'package:new_app/src/domain/repositories/firebase_repository.dart';

class FirebaseRepoImpl implements FirebaseRepository {
  final RemoteDataSource remoteDataSource;

  FirebaseRepoImpl({required this.remoteDataSource});

  @override
  Stream<List<UserEntity>> getCurretUser() {
    return remoteDataSource.getCurretUser();
  }

  @override
  Stream<User?> isSign() {
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

  @override
  Future<void> saveCalculatedRace(CalcluateEntity calc) {
    return remoteDataSource.saveCalculatedRace(calc);
  }

  @override
  Stream<List<CalcluateEntity>> getUserRaceList() {
    return remoteDataSource.getUserRaceList();
  }

  @override
  Future<void> deleteUserSingleCalculation(String postId) {
    return remoteDataSource.deleteUserSingleCalculation(postId);
  }

  @override
  Future<String> getCurrentUserUid() {
    // TODO: implement getCurrentUserUid
    throw UnimplementedError();
  }

  @override
  Stream<List<CalcluateEntity>> getAllUsersCalcList() {
    return remoteDataSource.getAllUserList();
  }

  @override
  Future<List<CalcluateEntity>> getCurrentUserCalcList() {
    return remoteDataSource.getCurrentUserCalcList();
  }
}
