import '../../repositories/firebase_repository.dart';

class RefreshNextPageUsecase {
  final FirebaseRepository firebaseRepository;

  RefreshNextPageUsecase({required this.firebaseRepository});
  call() {
    return firebaseRepository.refreshNextPage();
  }
}
