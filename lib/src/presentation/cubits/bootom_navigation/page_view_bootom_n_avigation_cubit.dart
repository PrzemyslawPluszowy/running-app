import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'page_view_bootom_n_avigation_state.dart';

class PageViewBootomNavigationCubit
    extends Cubit<PageViewBootomNavigationState> {
  PageViewBootomNavigationCubit() : super(PageViewIndex(index: 0));

  void pageViewIndex(int index) {
    emit(PageViewIndex(index: index));
  }
}
