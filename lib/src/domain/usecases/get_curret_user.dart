import 'package:new_app/src/domain/entities/user_entity.dart';
import 'package:new_app/src/domain/repositories/firebase_repository.dart';

class GetCurretUserUsecase {
  final FirebaseRepository firebaseRepository;

  GetCurretUserUsecase({required this.firebaseRepository});
  Stream<List<UserEntity>> call(String uid) {
    return firebaseRepository.getCurretUser(uid);
  }
}
