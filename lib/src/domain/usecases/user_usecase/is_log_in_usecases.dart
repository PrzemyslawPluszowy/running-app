import 'package:firebase_auth/firebase_auth.dart';

import '../../entities/user_entity.dart';
import '../../repositories/firebase_repository.dart';

class IsLogInUsecase {
  final FirebaseRepository fireRepository;

  IsLogInUsecase({required this.fireRepository});
  Stream<User?> call() {
    return fireRepository.isSign();
  }
}
