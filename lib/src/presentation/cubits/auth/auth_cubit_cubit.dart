import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/src/domain/entities/user_entity.dart';
import 'package:new_app/src/domain/usecases/get_curret_user_uid.dart';
import 'package:new_app/src/domain/usecases/is_log_in_usecases.dart';
import 'package:new_app/src/domain/usecases/log_in_usecases.dart';
import 'package:new_app/src/domain/usecases/log_out_usecases.dart';
import 'package:new_app/src/domain/usecases/register_user_usecase.dart';

import 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit(
      {required this.getCurretUserUidUsecase,
      required this.logOutUserUsecase,
      required this.isLogInUsecase,
      required this.logInUserUsecase,
      required this.registerUserUsecase})
      : super(AuthCubitInitial());

  final RegisterUserUsecase registerUserUsecase;
  final LogInUserUsecase logInUserUsecase;
  final IsLogInUsecase isLogInUsecase;
  final LogOutUserUsecase logOutUserUsecase;
  final GetCurretUserUidUsecase getCurretUserUidUsecase;

  void initApp() async {
    isLogInUsecase.fireRepository.isSign().listen((userUid) {
      if (userUid.isNotEmpty || userUid != null) {
        emit(IsLogInState(userUrid: userUid));
      } else {
        emit(IsLogOutState());
      }
    });
  }

  Future<void> registerUser({required UserEntity user}) async {
    emit(AuthCubitLoading());
    await Future.delayed(const Duration(seconds: 2), () {});

    try {
      await registerUserUsecase.call(user);
      emit(AuthCubiLoaded());
    } catch (e) {
      emit(AuthCubitError(error: e.toString()));
    }
  }

  Future<void> loginregisterUser(
      {required String email, required String password}) async {
    emit(AuthCubitLoading());
    await Future.delayed(const Duration(seconds: 2), () {});
    logInUserUsecase.call(email, password);
    try {
      emit(AuthCubiLoaded());
    } catch (e) {
      emit(AuthCubitError(error: e.toString()));
    }
  }

  Future<String> getCurretUid() async {
    String uid;
    uid = await getCurretUserUidUsecase.firebaseRepository.getCurrentUserUid();
    return uid;
  }

  void logout() {
    logInUserUsecase.fireRepository.logOut();
  }
}