import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:new_app/src/domain/usecases/user_stats_andlist/get_llist_vdots.dart';

part 'user_stats_state.dart';

class UserStatsCubit extends Cubit<UserStatsState> {
  UserStatsCubit({
    required this.getListVdotsUsecase,
  }) : super(UserStatsInitial());
  final GetListVdotsUsecase getListVdotsUsecase;

  showUserStats() async* {
    List<int> listOfvdot;
    emit(UserStatsLoading());
    getListVdotsUsecase.call().listen((event) {
      print(event);
      listOfvdot = event;
      emit(UserStatsLoaded(listOfvdot: listOfvdot));
    }).onError((err) {
      print(err);
    });
  }
}
