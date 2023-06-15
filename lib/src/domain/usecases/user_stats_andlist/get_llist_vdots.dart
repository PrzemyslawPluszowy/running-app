import 'dart:async';

import '../../entities/calcuate_entity.dart';
import '../../repositories/firebase_repository.dart';

class GetListVdotsUsecase {
  final FirebaseRepository firebaseRepository;
  GetListVdotsUsecase({
    required this.firebaseRepository,
  });
  Stream<List<int>> call() async* {
    Stream<List<CalcluateEntity>> stream = firebaseRepository.getUserRaceList();
    await for (final data in stream) {
      List<int> streamOutput = [];
      for (final item in data) {
        if (item.vdot != null) {
          streamOutput.add(item.vdot!);
        }
      }
      yield streamOutput;
    }
  }
}
