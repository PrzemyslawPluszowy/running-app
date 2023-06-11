import 'dart:async';

import 'package:new_app/src/domain/entities/calcuate_entity.dart';
import 'package:new_app/src/presentation/cubits/calculator/calculator_cubit.dart';

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
