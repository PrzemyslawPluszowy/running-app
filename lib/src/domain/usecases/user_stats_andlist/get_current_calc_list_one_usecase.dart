import 'package:new_app/src/core/ext/extension.dart';
import 'package:new_app/src/domain/repositories/firebase_repository.dart';

import '../../entities/calcuate_entity.dart';

class GetCurrentCalcListOneUsecase {
  final FirebaseRepository firebaseRepository;

  GetCurrentCalcListOneUsecase({required this.firebaseRepository});

  Future<double> call() async {
    List<int> listVdot = [];
    List<CalcluateEntity> listCalculated =
        await firebaseRepository.getCurrentUserCalcList();
    for (var calcuated in listCalculated) {
      if (calcuated.vdot != null) {
        listVdot.add(calcuated.vdot!);
      }
    }
    return listVdot.avgFromInt();
  }
}
