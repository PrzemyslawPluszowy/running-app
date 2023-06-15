import 'package:new_app/src/domain/entities/calcuate_entity.dart';
import 'package:new_app/src/domain/repositories/firebase_repository.dart';

class FetchPaginatedUsecase {
  final FirebaseRepository firebaseRepository;

  FetchPaginatedUsecase({required this.firebaseRepository});

  Future<List<CalcluateEntity>> call() {
    return firebaseRepository.fetchNextPage();
  }
}
