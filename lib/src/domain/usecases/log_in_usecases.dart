import '../repositories/firebase_repository.dart';

class LogInUserUsecase {
  final FirebaseRepository fireRepository;

  LogInUserUsecase({required this.fireRepository});
  Future<void> call(String email, String password) {
    return fireRepository.logIn(email, password);
  }
}
