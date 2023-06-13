import 'dart:async';

import '../../repositories/firebase_repository.dart';

class GetListVdotsUsecase {
  final FirebaseRepository firebaseRepository;
  GetListVdotsUsecase({
    required this.firebaseRepository,
  });
  Stream<List<int>> call() async* {}

  // Stream<List<int>> convertStream(Stream<List<CalcluateEntity>> stream) async* {
  //   await for (var list in stream) {
  //     for (var entity in list) {
  //       yield entity.vdot!;
  //     }
  //   }
  // }
}
