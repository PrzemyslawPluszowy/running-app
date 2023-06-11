import 'package:new_app/src/domain/entities/vdot_pace_entity.dart';

import '../../repositories/vdot_traning_pace.dart';

class GetVdtotTrainingPaceUsecase {
  final VdotTraningPaceRepo vdotTraningPaceRepo;

  GetVdtotTrainingPaceUsecase({required this.vdotTraningPaceRepo});

  VdotTraningPaceEntity call({required int vdot}) {
    return vdotTraningPaceRepo.getVdotTraningPace(vdot: vdot);
  }
}
