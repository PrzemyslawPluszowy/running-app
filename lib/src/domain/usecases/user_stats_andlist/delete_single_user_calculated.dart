import 'package:new_app/src/domain/repositories/firebase_repository.dart';

class DeleteSingleUserCalculatedUseCase {
  final FirebaseRepository firebaseRepository;

  DeleteSingleUserCalculatedUseCase({required this.firebaseRepository});

  call(String postId) {
    return firebaseRepository.deleteUserSingleCalculation(postId);
  }
}
