import 'package:new_app/src/domain/entities/vdot_pace_entity.dart';

import '../../data/models/traning_pace_vdot.model.dart';

abstract class VdotTraningPaceRepo {
  VdotTraningPaceEntity getVdotTraningPace({required int vdot});

  List<VdotTraningPaceEntity> getVdotTraningPaceList();
}
