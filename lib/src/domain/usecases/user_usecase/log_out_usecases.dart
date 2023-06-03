import '../../repositories/firebase_repository.dart';

class LogOutUserUsecase {
  final FirebaseRepository fireRepository;

  LogOutUserUsecase({required this.fireRepository});
  Future<void> call() {
    return fireRepository.logOut();
  }
}
