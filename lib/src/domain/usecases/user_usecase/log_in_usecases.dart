import '../../repositories/firebase_repository.dart';

class LogInUserUsecase {
  final FirebaseRepository fireRepository;

  LogInUserUsecase({required this.fireRepository});
  Future<String> call(String email, String password) {
    return fireRepository.logIn(email, password);
  }
}
