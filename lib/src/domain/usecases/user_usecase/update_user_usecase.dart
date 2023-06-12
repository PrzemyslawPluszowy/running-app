import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:new_app/src/domain/entities/user_entity.dart';

import '../../repositories/firebase_repository.dart';

class UpdateUserUseCase {
  final FirebaseRepository firebaseRepository;

  UpdateUserUseCase({required this.firebaseRepository});

  call(UserEntity userUpdate) {
    return firebaseRepository.updateUserFields(userUpdate);
  }
}
