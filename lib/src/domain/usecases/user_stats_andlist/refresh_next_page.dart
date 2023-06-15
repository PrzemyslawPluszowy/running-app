import 'package:firebase_core/firebase_core.dart';
import 'package:new_app/src/data/repositories/firebase_repo_impl.dart';
import 'package:new_app/src/presentation/cubits/calculator/calculator_cubit.dart';

import '../../repositories/firebase_repository.dart';

class RefreshNextPageUsecase {
  final FirebaseRepository firebaseRepository;

  RefreshNextPageUsecase({required this.firebaseRepository});
  call() {
    return firebaseRepository.refreshNextPage();
  }
}
