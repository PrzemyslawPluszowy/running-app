import 'package:new_app/src/data/models/traning_pace_vdot.model.dart';
import 'package:new_app/src/domain/entities/vdot_pace_entity.dart';

abstract class DbvDtotTraningPace {
  List<VdotTraningPaceEntity> getVdotTraningPace();
}
