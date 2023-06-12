import 'package:new_app/src/domain/entities/vdot_pace_entity.dart';

abstract class VdotTraningPaceRepo {
  VdotTraningPaceEntity getVdotTraningPace({required int vdot});

  List<VdotTraningPaceEntity> getVdotTraningPaceList();
}
