import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:new_app/src/domain/entities/user_entity.dart';
import 'package:new_app/src/domain/usecases/user_usecase/update_user_usecase.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit({required this.updateUserUseCase}) : super(SettingInitial());

  final UpdateUserUseCase updateUserUseCase;

  Future<void> updateUserField(UserEntity updateUserData) async {
    try {
      emit(SettingLoadingState());
      await updateUserUseCase.call(updateUserData);
      emit(SettingLoadedState());
      Fluttertoast.showToast(
          msg: "Update Success",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error: $e",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }
}
