import 'package:new_app/src/domain/entities/calcuate_entity.dart';
import 'package:new_app/src/domain/repositories/firebase_repository.dart';

class SaveCalculatedRaceUsecase {
  final FirebaseRepository firebaseRepository;

  const SaveCalculatedRaceUsecase({required this.firebaseRepository});

  Future<void> call(CalcluateEntity calc) {
    return firebaseRepository.saveCalculatedRace(calc);
  }
}
