import 'package:new_app/src/core/constants/vdot_traning_pace.dart';
import 'package:new_app/src/data/datasources/get_vdto_traning_pace.dart';
import 'package:new_app/src/data/models/traning_pace_vdot.model.dart';
import 'package:new_app/src/domain/entities/vdot_pace_entity.dart';

class DbvDotTraningPaceImpl implements DbvDtotTraningPace {
  @override
  List<VdotTraningPaceEntity> getVdotTraningPace() {
    List<VdotTraningPaceEntity> vDotList = [];

    for (var element in vDotTraningPaceData) {
      vDotList.add(VdotTraningPaceModel.fromJson(element).toEntity());
    }
    return vDotList;
  }
}
//   @override
//   VdotTraningPaceModel getVdotTraningPaceModel(int vdot) {
//     vdots = getVdotTraningPace();
//   }
// }
