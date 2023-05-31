import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:new_app/src/data/datasources/remote_data_source.dart';
import 'package:new_app/src/data/datasources/remote_data_source_impl.dart';
import 'package:new_app/src/data/repositories/firebase_repo_impl.dart';
import 'package:new_app/src/domain/repositories/calculator_repo.dart';
import 'package:new_app/src/data/repositories/calculator_repo_impl.dart';
import 'package:new_app/src/domain/repositories/firebase_repository.dart';
import 'package:new_app/src/domain/usecases/get_curret_user.dart';
import 'package:new_app/src/domain/usecases/get_curret_user_uid.dart';
import 'package:new_app/src/domain/usecases/is_log_in_usecases.dart';
import 'package:new_app/src/domain/usecases/log_in_usecases.dart';
import 'package:new_app/src/domain/usecases/log_out_usecases.dart';
import 'package:new_app/src/domain/usecases/register_user_usecase.dart';
import 'package:new_app/src/domain/usecases/calculator_usecase/set_distance_usecase.dart';
import 'package:new_app/src/domain/usecases/calculator_usecase/set_pace_usecases.dart';
import 'package:new_app/src/domain/usecases/calculator_usecase/set_race_time.dart';
import 'package:new_app/src/presentation/cubits/auth/auth_cubit_cubit.dart';
import 'package:new_app/src/presentation/cubits/bootom_navigation/page_view_bootom_n_avigation_cubit.dart';
import 'package:new_app/src/presentation/cubits/calculator/calculator_cubit.dart';
import 'package:new_app/src/presentation/cubits/user/user_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // register cubit
  getIt.registerFactory(() => AuthCubit(
      registerUserUsecase: getIt.call(),
      logInUserUsecase: getIt.call(),
      isLogInUsecase: getIt.call(),
      logOutUserUsecase: getIt.call(),
      getCurretUserUidUsecase: getIt.call()));

  getIt.registerFactory(() => UserCubit(getCurretUserUsecase: getIt.call()));
  getIt.registerFactory(() => PageViewBootomNavigationCubit());
  getIt.registerFactory(() => CalculatorCubit(
        setDistanceUseCase: getIt.call(),
        setPaceUseCase: getIt.call(),
        setRaceTimeUseCase: getIt.call(),
      ));

  //register usecases

  getIt.registerLazySingleton(
      () => SetDistanceUseCase(runningCalulator: getIt.call()));
  getIt.registerLazySingleton(
      () => SetPaceUseCase(runningCalulator: getIt.call()));
  getIt.registerLazySingleton(
      () => SetRaceTimeUseCase(runningCalulator: getIt.call()));
  getIt.registerLazySingleton(
      () => IsLogInUsecase(fireRepository: getIt.call()));
  getIt.registerLazySingleton(
      () => RegisterUserUsecase(fireRepository: getIt.call()));
  getIt.registerLazySingleton(
      () => LogOutUserUsecase(fireRepository: getIt.call()));
  getIt.registerLazySingleton(
      () => LogInUserUsecase(fireRepository: getIt.call()));
  getIt.registerLazySingleton(
      () => GetCurretUserUidUsecase(firebaseRepository: getIt.call()));
  getIt.registerLazySingleton(
      () => GetCurretUserUsecase(firebaseRepository: getIt.call()));
  //register impl
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
