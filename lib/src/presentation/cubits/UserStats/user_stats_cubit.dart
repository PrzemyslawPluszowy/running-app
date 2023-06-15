import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_app/src/domain/entities/user_entity.dart';
import 'package:new_app/src/domain/entities/vdot_pace_entity.dart';
import 'package:new_app/src/domain/usecases/user_stats_andlist/etimated_race_usecase.dart';
import 'package:new_app/src/domain/usecases/user_stats_andlist/get_current_calc_list_one_usecase.dart';
import 'package:new_app/src/domain/usecases/user_stats_andlist/get_hr_zone.dart';
import 'package:new_app/src/domain/usecases/user_stats_andlist/get_vdot_traning_pace.dart';
import 'package:new_app/src/domain/usecases/user_usecase/get_curret_user.dart';

part 'user_stats_state.dart';

class UserStatsCubit extends Cubit<UserStatsState> {
  UserStatsCubit({
    required this.estimatedRaceTimeUseCase,
    required this.getHrZoneUseCase,
    required this.getCurrentCalcListOneUsecase,
    required this.getCurretUserUsecase,
    required this.getVdtotTrainingPaceUsecase,
  }) : super(UserStatsInitial());
  final GetCurretUserUsecase getCurretUserUsecase;
  final GetVdtotTrainingPaceUsecase getVdtotTrainingPaceUsecase;
  final GetCurrentCalcListOneUsecase getCurrentCalcListOneUsecase;
  final GetHrZoneUseCase getHrZoneUseCase;
  final EstimatedRaceTimeUseCase estimatedRaceTimeUseCase;

//
  late int age;
  late int weight;
  late int height;
  late int hrMax;
  late int hrRest;
  late double bmi;
  late int vdot;
  late String name;
  late double avgVdot;
  //traning pace
  late int distance;
  late Duration easyPace;
  late Duration thresholdPace;
  late Duration intervalPace;
  late Duration repetitionPace;
  late Duration marathonPace;

  //hr zone
  late int easyZoneMin;
  late int easyZoneMax;
  late int marathonZoneMin;
  late int marathonZoneMax;
  late int thresholdZoneMin;
  late int thresholdZoneMax;
  late int intervalZoneMin;
  late int intervalZoneMax;
  late int repetitionZoneMin;
  late int repetitionZoneMax;
  //estimated race time
  late Duration marathonTime;
  late Duration halfMarathonTime;
  late Duration m15km;
  late Duration tenKmTime;
  late Duration fiveKmTime;
  late Duration m3200;
  late Duration m1600;
  late Duration m1500;

  showUserStats() async {
    emit(UserStatsInitial());
    getCurretUserUsecase.firebaseRepository
        .getCurretUser()
        .listen((event) async {
      emit(UserStatsInitial());
      double avgVdot = await getCurrentCalcListOneUsecase.call();
      UserEntity user = event.first;
      if (user.vdot == null) {
        emit(UserStatsError());
        return;
      }
      EsitamtedRaceTime raceTime =
          estimatedRaceTimeUseCase.call(vdot: user.vdot!.toInt());

      HrZone hrZone =
          getHrZoneUseCase.call(hrMax: user.hrMax!, hrMin: user.hrRest!);
      VdotTraningPaceEntity traningPace =
          getVdtotTrainingPaceUsecase.call(vdot: user.vdot!.toInt());
      generateStatsToShow(user, traningPace, hrZone, raceTime);

      emit(UserStatsLoaded(
          age: age,
          weight: weight,
          height: height,
          hrMax: hrMax,
          hrRest: hrRest,
          bmi: bmi,
          vdot: vdot,
          name: name,
          avgVdot: double.parse(avgVdot.toStringAsFixed(2)),
          //user pace traning
          distance: distance,
          easyPace: easyPace,
          thresholdPace: thresholdPace,
          intervalPace: intervalPace,
          repetitionPace: repetitionPace,
          marathonPace: marathonPace,
          //hr zone
          easyZoneMin: easyZoneMin,
          easyZoneMax: easyZoneMax,
          marathonZoneMin: marathonZoneMin,
          marathonZoneMax: marathonZoneMax,
          thresholdZoneMin: thresholdZoneMin,
          thresholdZoneMax: thresholdZoneMax,
          intervalZoneMin: intervalZoneMin,
          intervalZoneMax: intervalZoneMax,
          repetitionZoneMin: repetitionZoneMin,
          repetitionZoneMax: repetitionZoneMax,
          //estimated race time
          marathonTime: marathonTime,
          halfMarathonTime: halfMarathonTime,
          tenKmTime: tenKmTime,
          fiveKmTime: fiveKmTime,
          m3200: m3200,
          m1600: m1600,
          m1500: m1500,
          m15km: m15km));
    }).onError((err) {
      Fluttertoast.showToast(msg: err.toString());
    });
  }

  generateStatsToShow(UserEntity user, VdotTraningPaceEntity traningPace,
      HrZone hrZone, EsitamtedRaceTime raceTime) {
    age = user.age!;
    weight = user.weight!;
    height = user.height!;
    hrMax = user.hrMax!;
    hrRest = user.hrRest!;
    bmi = user.bmi!.toDouble();
    name = user.userName!;
    vdot = user.vdot!.toInt();
    //traning pace
    distance = traningPace.distance;
    easyPace = traningPace.easyPace;
    thresholdPace = traningPace.thresholdPace;
    intervalPace = traningPace.intervalPace;
    repetitionPace = traningPace.repetitionPace;
    marathonPace = traningPace.marathonPace;
    //hr zone
    easyZoneMin = hrZone.easyMin;
    easyZoneMax = hrZone.easyMax;
    marathonZoneMin = hrZone.marathonMin;
    marathonZoneMax = hrZone.marathonMax;
    thresholdZoneMin = hrZone.thresholdMin;
    thresholdZoneMax = hrZone.thresholdMax;
    intervalZoneMin = hrZone.intervalMin;
    intervalZoneMax = hrZone.intervalMax;
    repetitionZoneMin = hrZone.repMin;
    repetitionZoneMax = hrZone.repMax;
    //race time
    marathonTime = raceTime.m42k;
    halfMarathonTime = raceTime.m21k;
    tenKmTime = raceTime.m10k;
    fiveKmTime = raceTime.m5k;
    m3200 = raceTime.m3200;
    m1600 = raceTime.m1600;
    m1500 = raceTime.m1500;
    m15km = raceTime.km15;
  }
}
