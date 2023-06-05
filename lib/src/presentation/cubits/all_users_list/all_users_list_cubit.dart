import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_app/src/domain/entities/calcuate_entity.dart';
import 'package:new_app/src/domain/usecases/user_stats_andlist/get_all_users_calc_list_usecase.dart';

part 'all_users_list_state.dart';

class AllUsersListCubit extends Cubit<AllUsersListState> {
  AllUsersListCubit({required this.getAllUsersCalcList})
      : super(AllUsersListInitial());
  final GetAllUsersCalcList getAllUsersCalcList;

  showAllUserCalcList() async {
    List<CalcluateEntity> listToShow;
    emit(AllUsersListLoading());
    getAllUsersCalcList.call().listen((event) {
      listToShow = event;
      emit(AllUsersListLoaded(listToshow: listToShow));
    }).onError((err) {
      Fluttertoast.showToast(msg: err.toString());
    });
  }
}
