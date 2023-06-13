import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:new_app/src/domain/entities/calcuate_entity.dart';
import 'package:new_app/src/domain/usecases/user_stats_andlist/fetch_paginateted_usecase.dart';
import 'package:new_app/src/domain/usecases/user_stats_andlist/get_all_users_calc_list_usecase.dart';

part 'all_users_list_state.dart';

class AllUsersListCubit extends Cubit<AllUsersListState> {
  AllUsersListCubit(
      {required this.fetchPaginatedUsecase, required this.getAllUsersCalcList})
      : super(const AllUsersListLoading(null));

  final GetAllUsersCalcList getAllUsersCalcList;
  final FetchPaginatedUsecase fetchPaginatedUsecase;
  List<CalcluateEntity> listToShow = [];
  bool _isFirstTime = true;
  bool _isEndOfList = false;

  fetchNextPage() async {
    if (_isFirstTime) {
      emit(const AllUsersListLoading(null));
      _isFirstTime = false;
    }
    if (_isEndOfList) {
      emit(AllUsersListState(
          listToshow: listToShow, isLoading: false, isEndOfList: true));
      return;
    }

    emit(AllUsersListState(
        listToshow: listToShow, isLoading: true, isEndOfList: false));
    await Future.delayed(const Duration(seconds: 1));
    final nextData = await fetchPaginatedUsecase.call();
    if (nextData.isEmpty) {
      _isEndOfList = true;

      emit(AllUsersListState(
          listToshow: listToShow, isLoading: false, isEndOfList: true));
      return;
    }
    listToShow = [...?state.listToshow, ...nextData];
    emit(AllUsersListState(
        listToshow: listToShow, isLoading: false, isEndOfList: false));
  }
}
