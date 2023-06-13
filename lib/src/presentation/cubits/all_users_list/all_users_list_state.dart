part of 'all_users_list_cubit.dart';

class AllUsersListState extends Equatable {
  final List<CalcluateEntity>? listToshow;
  final bool isLoading;
  final bool isEndOfList;

  const AllUsersListState(
      {required this.isLoading,
      required this.listToshow,
      required this.isEndOfList});
  @override
  List<Object?> get props => [listToshow, isLoading, isEndOfList];
}

class AllUsersListLoading extends AllUsersListState {
  const AllUsersListLoading(List<CalcluateEntity>? listToshow)
      : super(listToshow: null, isLoading: true, isEndOfList: false);
}
