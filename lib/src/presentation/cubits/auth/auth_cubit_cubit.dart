import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/src/domain/entities/user_entity.dart';
import 'package:new_app/src/domain/usecases/user_usecase/get_curret_user_uid.dart';
import 'package:new_app/src/domain/usecases/user_usecase/is_log_in_usecases.dart';
import 'package:new_app/src/domain/usecases/user_usecase/log_in_usecases.dart';
import 'package:new_app/src/domain/usecases/user_usecase/log_out_usecases.dart';
import 'package:new_app/src/domain/usecases/user_usecase/register_user_usecase.dart';

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
    isLogInUsecase.call().listen((event) {
      if (event != null) {
        emit(IsLogInState());
      } else {
        emit(IsLogOutState());
      }
    });
  }

  Future<void> registerUser({required UserEntity user}) async {
    emit(AuthCubitLoading());

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

  void logout() {
    logInUserUsecase.fireRepository.logOut();
  }
}
