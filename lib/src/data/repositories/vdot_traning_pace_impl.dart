import 'package:new_app/src/data/datasources/get_vdto_traning_pace.dart';

import 'package:new_app/src/domain/entities/vdot_pace_entity.dart';

import '../../domain/repositories/vdot_traning_pace.dart';

class VdotTraningPaceRepoImpl implements VdotTraningPaceRepo {
  final DbvDtotTraningPace dbvDotTraningPace;

  VdotTraningPaceRepoImpl({required this.dbvDotTraningPace});
  @override
  List<VdotTraningPaceEntity> getVdotTraningPaceList() {
    return dbvDotTraningPace.getVdotTraningPace();
  }

  @override
  VdotTraningPaceEntity getVdotTraningPace({required int vdot}) {
    List<VdotTraningPaceEntity> listToSort = getVdotTraningPaceList();
    var vdotParamsToShow =
        listToSort.where((element) => element.vdot == vdot).toList().first;
    return vdotParamsToShow;
  }
}
