import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:new_app/src/data/datasources/get_vdto_traning_pace.dart';
import 'package:new_app/src/data/datasources/get_vdto_traning_pace_impl.dart';
import 'package:new_app/src/data/datasources/remote_data_source.dart';
import 'package:new_app/src/data/datasources/remote_data_source_impl.dart';
import 'package:new_app/src/data/repositories/firebase_repo_impl.dart';
import 'package:new_app/src/data/repositories/vdot_traning_pace_impl.dart';
import 'package:new_app/src/domain/repositories/calculator_repo.dart';
import 'package:new_app/src/data/repositories/calculator_repo_impl.dart';
import 'package:new_app/src/domain/repositories/firebase_repository.dart';
import 'package:new_app/src/domain/repositories/vdot_traning_pace.dart';
import 'package:new_app/src/domain/usecases/calculator_usecase/calcluate_race_time_usecase.dart';
import 'package:new_app/src/domain/usecases/calculator_usecase/calculate_pace_usecase.dart';
import 'package:new_app/src/domain/usecases/user_stats_andlist/etimated_race_usecase.dart';
import 'package:new_app/src/domain/usecases/user_stats_andlist/get_current_calc_list_one_usecase.dart';
import 'package:new_app/src/domain/usecases/user_stats_andlist/get_hr_zone.dart';
import 'package:new_app/src/domain/usecases/user_stats_andlist/get_llist_vdots.dart';
import 'package:new_app/src/domain/usecases/user_stats_andlist/get_user_race_list.dart';
import 'package:new_app/src/domain/usecases/calculator_usecase/get_vdot_usecase.dart';
import 'package:new_app/src/domain/usecases/user_stats_andlist/get_vdot_traning_pace.dart';
import 'package:new_app/src/domain/usecases/user_usecase/forgot_password_usecase.dart';
import 'package:new_app/src/domain/usecases/user_usecase/get_curret_user.dart';
import 'package:new_app/src/domain/usecases/user_usecase/is_log_in_usecases.dart';
import 'package:new_app/src/domain/usecases/user_stats_andlist/delete_single_user_calculated.dart';
import 'package:new_app/src/domain/usecases/user_stats_andlist/get_all_users_calc_list_usecase.dart';
import 'package:new_app/src/domain/usecases/user_usecase/log_in_usecases.dart';
import 'package:new_app/src/domain/usecases/user_usecase/log_out_usecases.dart';
import 'package:new_app/src/domain/usecases/user_usecase/register_user_usecase.dart';
import 'package:new_app/src/domain/usecases/calculator_usecase/save_calculated_race.dart';
import 'package:new_app/src/domain/usecases/user_usecase/update_user_usecase.dart';
import 'package:new_app/src/presentation/cubits/UserStats/user_stats_cubit.dart';
import 'package:new_app/src/presentation/cubits/all_users_list/all_users_list_cubit.dart';
import 'package:new_app/src/presentation/cubits/auth/auth_cubit_cubit.dart';
import 'package:new_app/src/presentation/cubits/bootom_navigation/page_view_bootom_n_avigation_cubit.dart';
import 'package:new_app/src/presentation/cubits/calculator/calculator_cubit.dart';
import 'package:new_app/src/presentation/cubits/list_race_calulated/list_race_calculated_cubit.dart';
import 'package:new_app/src/presentation/cubits/setting_page/setting_cubit.dart';
import 'package:new_app/src/presentation/cubits/user/user_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // register cubit
  getIt.registerFactory(() => AuthCubit(
        registerUserUsecase: getIt.call(),
        logInUserUsecase: getIt.call(),
        isLogInUsecase: getIt.call(),
        logOutUserUsecase: getIt.call(),
        forgotPasswordUseCase: getIt.call(),
      ));

  getIt.registerFactory(() => UserCubit(getCurretUserUsecase: getIt.call()));
  getIt.registerFactory(() => PageViewBootomNavigationCubit());
  getIt.registerFactory(() => CalculatorCubit(
        getVdotUseCase: getIt.call(),
        saveCalculatedRaceUsecase: getIt.call(),
        calculatePaceUseCase: getIt.call(),
        calculateRaceTimeUseCase: getIt.call(),
      ));
  getIt.registerFactory(() => ListRaceCalculatedCubit(
      getUserRaceListUsecase: getIt.call(),
      deleteSingleUserCalculatedUseCase: getIt.call()));
  getIt.registerFactory(() => AllUsersListCubit(
        getAllUsersCalcList: getIt.call(),
      ));
  getIt.registerFactory(() => UserStatsCubit(
      getCurretUserUsecase: getIt.call(),
      getVdtotTrainingPaceUsecase: getIt.call(),
      getCurrentCalcListOneUsecase: getIt.call(),
      getHrZoneUseCase: getIt.call(),
      estimatedRaceTimeUseCase: getIt.call()));

  getIt.registerFactory(() => SettingCubit(updateUserUseCase: getIt.call()));

  //register usecases
  getIt.registerLazySingleton(() => ForgotPasswordUseCase(
        firebaseRepository: getIt.call(),
      ));
  getIt.registerLazySingleton(
      () => UpdateUserUseCase(firebaseRepository: getIt.call()));
  getIt.registerLazySingleton(() => EstimatedRaceTimeUseCase());
  getIt.registerLazySingleton(() => GetHrZoneUseCase());
  getIt.registerLazySingleton(
      () => GetCurrentCalcListOneUsecase(firebaseRepository: getIt.call()));
  getIt.registerLazySingleton(
      () => GetVdtotTrainingPaceUsecase(vdotTraningPaceRepo: getIt.call()));
  getIt.registerLazySingleton(
      () => GetListVdotsUsecase(firebaseRepository: getIt.call()));
  getIt.registerLazySingleton(
      () => CalculatePaceUseCase(runningCalulator: getIt.call()));
  getIt.registerLazySingleton(
      () => CalculateRaceTimeUseCase(runningCalulator: getIt.call()));
  getIt.registerLazySingleton(
      () => GetAllUsersCalcList(remoteDataSource: getIt.call()));

  getIt.registerLazySingleton(() =>
      DeleteSingleUserCalculatedUseCase(firebaseRepository: getIt.call()));
  getIt.registerLazySingleton(
      () => GetUserRaceListUsecase(firebaseRepository: getIt.call()));
  getIt.registerLazySingleton(
      () => SaveCalculatedRaceUsecase(firebaseRepository: getIt.call()));
  getIt.registerLazySingleton(
      () => GetVdotUseCase(runningCalulator: getIt.call()));

  getIt.registerLazySingleton(
      () => IsLogInUsecase(fireRepository: getIt.call()));
  getIt.registerLazySingleton(
      () => RegisterUserUsecase(fireRepository: getIt.call()));
  getIt.registerLazySingleton(
      () => LogOutUserUsecase(fireRepository: getIt.call()));
  getIt.registerLazySingleton(
      () => LogInUserUsecase(fireRepository: getIt.call()));

  getIt.registerLazySingleton(
      () => GetCurretUserUsecase(firebaseRepository: getIt.call()));
  //register impl

  getIt.registerLazySingleton<DbvDtotTraningPace>(
    () => DbvDotTraningPaceImpl(),
  );
  getIt.registerLazySingleton<VdotTraningPaceRepo>(
    () => VdotTraningPaceRepoImpl(dbvDotTraningPace: getIt.call()),
  );
  getIt.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepoImpl(remoteDataSource: getIt.call()));
  getIt.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(
      firebaseAuth: getIt.call(),
      firebaseFirestore: getIt.call(),
      firebaseStorage: getIt.call()));

  getIt.registerLazySingleton<RunningCalulator>(() => RunningCalculatorImpl());

  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;
  getIt.registerLazySingleton(() => firebaseAuth);
  getIt.registerLazySingleton(() => firebaseFirestore);
  getIt.registerLazySingleton(() => firebaseStorage);
}
