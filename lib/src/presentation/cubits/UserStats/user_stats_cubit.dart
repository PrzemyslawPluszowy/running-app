import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_app/src/domain/entities/user_entity.dart';
import 'package:new_app/src/domain/entities/vdot_pace_entity.dart';
import 'package:new_app/src/domain/usecases/user_stats_andlist/etimated_race_usecase.dart';
import 'package:new_app/src/domain/usecases/user_stats_andlist/get_current_calc_list_one_usecase.dart';
import 'package:new_app/src/domain/usecases/user_stats_andlist/get_hr_zone.dart';
import 'package:new_app/src/domain/usecases/user_stats_andlist/get_llist_vdots.dart';
import 'package:new_app/src/domain/usecases/user_stats_andlist/get_vdot_traning_pace.dart';
import 'package:new_app/src/domain/usecases/user_usecase/get_curret_user.dart';

part 'user_stats_state.dart';

class UserStatsCubit extends Cubit<UserStatsState> {
  UserStatsCubit({
    required this.getListVdotsUsecase,
    required this.estimatedRaceTimeUseCase,
    required this.getHrZoneUseCase,
    required this.getCurrentCalcListOneUsecase,
    required this.getCurretUserUsecase,
    required this.getVdtotTrainingPaceUsecase,
  }) : super(const UserStatsInitial());
  final GetCurretUserUsecase getCurretUserUsecase;
  final GetVdtotTrainingPaceUsecase getVdtotTrainingPaceUsecase;
  final GetCurrentCalcListOneUsecase getCurrentCalcListOneUsecase;
  final GetHrZoneUseCase getHrZoneUseCase;
  final EstimatedRaceTimeUseCase estimatedRaceTimeUseCase;
  final GetListVdotsUsecase getListVdotsUsecase;

  showUserStats() async {
    emit(const UserStatsInitial());
    getCurretUserUsecase.call().listen((users) async {
      UserEntity user = users.first;
      if (user.vdot == null) {
        emit(UserStatsError());
        return;
      }
      EsitamtedRaceTime raceTime =
          await estimatedRaceTimeUseCase.call(vdot: user.vdot!.toInt());
      double avgVdot = await getCurrentCalcListOneUsecase.call();

      HrZone hrZone =
          await getHrZoneUseCase.call(hrMax: user.hrMax!, hrMin: user.hrRest!);
      VdotTraningPaceEntity traningPace =
          getVdtotTrainingPaceUsecase.call(vdot: user.vdot!.toInt());
      getListVdotsUsecase.call().listen((list) {
        emit(UserStatsLoaded(
          vdotList: list,
          age: user.age!,
          weight: user.weight!,
          height: user.height!,
          hrMax: user.hrMax!,
          hrRest: user.hrRest!,
          bmi: user.bmi!,
          vdot: user.vdot!.toInt(),
          name: user.userName!,
          distance: traningPace.distance,
          avgVdot: avgVdot,
          easyPace: traningPace.easyPace,
          thresholdPace: traningPace.thresholdPace,
          intervalPace: traningPace.intervalPace,
          repetitionPace: traningPace.repetitionPace,
          marathonPace: traningPace.marathonPace,
          easyZoneMin: hrZone.easyMin,
          easyZoneMax: hrZone.easyMax,
          marathonZoneMin: hrZone.marathonMin,
          marathonZoneMax: hrZone.marathonMax,
          thresholdZoneMin: hrZone.thresholdMin,
          thresholdZoneMax: hrZone.thresholdMax,
          intervalZoneMin: hrZone.intervalMin,
          intervalZoneMax: hrZone.intervalMax,
          repetitionZoneMin: hrZone.repMin,
          repetitionZoneMax: hrZone.repMax,
          marathonTime: raceTime.m42k,
          halfMarathonTime: raceTime.m21k,
          m15km: raceTime.km15,
          tenKmTime: raceTime.m10k,
          fiveKmTime: raceTime.m5k,
          m3200: raceTime.m3200,
          m1600: raceTime.m1600,
          m1500: raceTime.m1500,
        ));
      });
    });
  }
}
