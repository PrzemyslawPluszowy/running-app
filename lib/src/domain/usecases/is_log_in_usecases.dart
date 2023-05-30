import '../entities/user_entity.dart';
import '../repositories/firebase_repository.dart';

class IsLogInUsecase {
  final FirebaseRepository fireRepository;

  IsLogInUsecase({required this.fireRepository});
  Stream<String> call(UserEntity user) {
    return fireRepository.isSign();
  }
}
