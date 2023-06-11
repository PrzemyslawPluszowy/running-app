part of 'page_view_bootom_n_avigation_cubit.dart';

abstract class PageViewBootomNavigationState extends Equatable {}

class PageViewIndex extends PageViewBootomNavigationState {
  final int index;

  PageViewIndex({
    required this.index,
  });

  @override
  List<Object?> get props => [index];
}
