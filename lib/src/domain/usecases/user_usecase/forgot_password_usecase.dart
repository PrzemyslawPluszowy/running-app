import '../../repositories/firebase_repository.dart';

class ForgotPasswordUseCase {
  final FirebaseRepository firebaseRepository;

  ForgotPasswordUseCase({required this.firebaseRepository});

  Future<String> call(String email) async {
    return await firebaseRepository.forgotPassword(email);
  }
}
