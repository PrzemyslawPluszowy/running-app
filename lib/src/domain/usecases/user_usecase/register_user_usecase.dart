import 'package:new_app/src/domain/entities/user_entity.dart';
import 'package:new_app/src/domain/repositories/firebase_repository.dart';

class RegisterUserUsecase {
  final FirebaseRepository fireRepository;

  RegisterUserUsecase({required this.fireRepository});
  Future<void> call(UserEntity user) {
    return fireRepository.registerUser(user);
  }
}
