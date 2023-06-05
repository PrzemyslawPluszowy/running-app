import 'dart:async';

import 'package:new_app/src/domain/entities/calcuate_entity.dart';
import 'package:new_app/src/presentation/cubits/calculator/calculator_cubit.dart';

import '../../repositories/firebase_repository.dart';

class GetListVdotsUsecase {
  final FirebaseRepository firebaseRepository;
  GetListVdotsUsecase({
    required this.firebaseRepository,
  });
  Stream<List<int>> call() async* {
    final streamController = firebaseRepository.getUserRaceList();
    final convertedStream = convertStream();
    yield* convertedStream;
  }

  Stream<List<int>> convertStream() async* {
    final stream = firebaseRepository.getUserRaceList();

    yield* stream.transform(CalculateEntityTransformer());
  }

  // Stream<List<int>> convertStream(Stream<List<CalcluateEntity>> stream) async* {
  //   await for (var list in stream) {
  //     for (var entity in list) {
  //       yield entity.vdot!;
  //     }
  //   }
  // }
}

class CalculateEntityTransformer
    extends StreamTransformerBase<List<CalcluateEntity>, List<int>> {
  @override
  Stream<List<int>> bind(Stream<List<CalcluateEntity>> stream) {
    return stream.map((list) => list.map((CalcluateEntity entity) {
          return entity.vdot!;
        }).toList());
  }
}
// Stream<List<int>> call() async* {
  //   final Stream<List<CalcluateEntity>> stream =
  //       firebaseRepository.getUserRaceList();

  //   await for (final List<CalcluateEntity> list in stream) {
  //     final List<int> listVdots = [];
  //     for (final CalcluateEntity item in list) {
  //       if (item.vdot != null) {
  //         listVdots.add(item.vdot!);
  //       }
  //     }
  //     yield listVdots;
  //   }
  // }