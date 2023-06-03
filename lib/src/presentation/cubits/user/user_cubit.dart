import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_app/src/domain/entities/user_entity.dart';
import 'package:new_app/src/domain/usecases/get_curret_user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.getCurretUserUsecase}) : super(UserInitial());

  final GetCurretUserUsecase getCurretUserUsecase;

  void getCurretUser(String uid) async {
    emit(UserLoadingState());
    try {
      getCurretUserUsecase.firebaseRepository
          .getCurretUser(uid)
          .listen((event) {
        emit(UserLoadedState(loggedUser: event.first));
      });
    } on SocketException catch (e) {
      print(e);
    }
  }
}
