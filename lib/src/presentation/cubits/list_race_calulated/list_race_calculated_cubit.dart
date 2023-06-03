import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_app/src/domain/entities/calcuate_entity.dart';
import 'package:new_app/src/domain/usecases/calculator_usecase/get_user_race_list.dart';
import 'package:new_app/src/domain/usecases/list_calculation_useCase/delete_single_user_calculated.dart';

part 'list_race_calculated_state.dart';

class ListRaceCalculatedCubit extends Cubit<ListRaceCalculatedState> {
  ListRaceCalculatedCubit(
      {required this.deleteSingleUserCalculatedUseCase,
      required this.getUserRaceListUsecase})
      : super(ListRaceCalculatedInitial());
  final GetUserRaceListUsecase getUserRaceListUsecase;
  final DeleteSingleUserCalculatedUseCase deleteSingleUserCalculatedUseCase;

  void showCurretRaceList() {
    List<CalcluateEntity> list;
    getUserRaceListUsecase.call().listen((event) {
      list = event;
      emit(ListRaceCalculatedLoaded(list));
    }).onError((handleError) {
      Fluttertoast.showToast(msg: handleError.toString());
    });
  }

  void deleteSingleCalculatedPost(String postId) {
    emit(DeltePostInit());

    try {
      deleteSingleUserCalculatedUseCase.call(postId);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
