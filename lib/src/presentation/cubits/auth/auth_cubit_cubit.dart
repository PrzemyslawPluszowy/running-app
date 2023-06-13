import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_app/src/domain/entities/user_entity.dart';
import 'package:new_app/src/domain/usecases/user_usecase/forgot_password_usecase.dart';
import 'package:new_app/src/domain/usecases/user_usecase/is_log_in_usecases.dart';
import 'package:new_app/src/domain/usecases/user_usecase/log_in_usecases.dart';
import 'package:new_app/src/domain/usecases/user_usecase/log_out_usecases.dart';
import 'package:new_app/src/domain/usecases/user_usecase/register_user_usecase.dart';

import 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit(
      {required this.forgotPasswordUseCase,
      required this.logOutUserUsecase,
      required this.isLogInUsecase,
      required this.logInUserUsecase,
      required this.registerUserUsecase})
      : super(AuthCubitInitial());

  final RegisterUserUsecase registerUserUsecase;
  final LogInUserUsecase logInUserUsecase;
  final IsLogInUsecase isLogInUsecase;
  final LogOutUserUsecase logOutUserUsecase;
  final ForgotPasswordUseCase forgotPasswordUseCase;

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

    try {
      String res = await logInUserUsecase.call(email, password);
      if (res == 'wrong-password') {
        emit(AuthCubitForgotPass());
      } else {
        emit(IsLogInState());
      }
    } catch (e) {
      emit(AuthCubitError(error: e.toString()));
      Fluttertoast.showToast(
          msg: "Check your email to reset password",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }

  void forgotPassword({required String email}) async {
    emit(AuthCubitLoading());
    await Future.delayed(Duration(seconds: 2));
    String res = '';
    try {
      res = await forgotPasswordUseCase.call(email);
      if (res == 'success') {
        Fluttertoast.showToast(
            msg: "Check your email to reset password",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        emit(SendEmailSuccess());
      }
      if (res != 'success') {
        emit(AuthCubitErrForgetPass());
      }
    } catch (e) {
      emit(AuthCubitError(error: e.toString()));
    }
  }

  void logout() {
    logInUserUsecase.fireRepository.logOut();
    emit(IsLogOutState());
  }
}
