import 'package:firebase_core/firebase_core.dart';
import 'package:new_app/src/data/repositories/firebase_repo_impl.dart';
import 'package:new_app/src/domain/entities/calcuate_entity.dart';
import 'package:new_app/src/domain/repositories/firebase_repository.dart';
import 'package:new_app/src/presentation/cubits/calculator/calculator_cubit.dart';

class FetchPaginatedUsecase {
  final FirebaseRepository firebaseRepository;

  FetchPaginatedUsecase({required this.firebaseRepository});

  Future<List<CalcluateEntity>> call() {
    return firebaseRepository.fetchNextPage();
  }
}
