import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:new_app/src/domain/entities/calcuate_entity.dart';
import 'package:new_app/src/domain/usecases/user_stats_andlist/fetch_paginateted_usecase.dart';
import 'package:new_app/src/domain/usecases/user_stats_andlist/refresh_next_page.dart';

part 'all_users_list_state.dart';

class AllUsersListCubit extends Cubit<AllUsersListState> {
  AllUsersListCubit({
    required this.refreshNextPageUsecase,
    required this.fetchPaginatedUsecase,
  }) : super(const AllUsersListLoading([]));

  final FetchPaginatedUsecase fetchPaginatedUsecase;
  final RefreshNextPageUsecase refreshNextPageUsecase;
  List<CalcluateEntity> listToShow = [];
  bool _isFirstTime = true;
  bool _isEndOfList = false;

  refresh() async {
    _isFirstTime = true;
    _isEndOfList = false;
    listToShow = [];
    await refreshNextPageUsecase.call();
    const AllUsersListLoading([]);
    fetchNextPage();
  }

  fetchNextPage() async {
    if (_isFirstTime) {
      emit(const AllUsersListLoading([]));
      _isFirstTime = false;
    }
    if (_isEndOfList) {
      emit(AllUsersListState(
          listToshow: listToShow, isLoading: false, isEndOfList: true));
      return;
    }
    emit(AllUsersListState(
        listToshow: listToShow, isLoading: true, isEndOfList: true));
    final nextData = await fetchPaginatedUsecase.call();
    if (nextData.isEmpty) {
      _isEndOfList = true;
      emit(AllUsersListState(
          listToshow: listToShow, isLoading: false, isEndOfList: true));
    } else {
      listToShow = [...?state.listToshow, ...nextData];
      emit(AllUsersListState(
          listToshow: listToShow, isLoading: false, isEndOfList: false));
    }
  }
}
