import 'package:new_app/src/domain/entities/calcuate_entity.dart';

import 'package:new_app/src/domain/repositories/firebase_repository.dart';

class GetUserRaceListUsecase {
  final FirebaseRepository firebaseRepository;
  GetUserRaceListUsecase({
    required this.firebaseRepository,
  });

  Stream<List<CalcluateEntity>> call() {
    return firebaseRepository.getUserRaceList();
  }
}
