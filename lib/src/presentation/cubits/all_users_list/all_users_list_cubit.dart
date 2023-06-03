import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_app/src/domain/entities/calcuate_entity.dart';
import 'package:new_app/src/domain/usecases/list_calculation_useCase/get_all_users_calc_list_usecase.dart';

part 'all_users_list_state.dart';

class AllUsersListCubit extends Cubit<AllUsersListState> {
  AllUsersListCubit({required this.getAllUsersCalcList})
      : super(const AllUsersListInitial(listToshow: []));
  final GetAllUsersCalcList getAllUsersCalcList;

  Future<void> showAllUserCalcList() async {
    List<CalcluateEntity> listToShow;
    getAllUsersCalcList.call().listen((event) {
      listToShow = event;
      emit(AllUsersListInitial(listToshow: listToShow));
    }).onError((err) {
      Fluttertoast.showToast(msg: err.toString());
    });
  }
}
