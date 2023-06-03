part of 'all_users_list_cubit.dart';

abstract class AllUsersListState extends Equatable {
  const AllUsersListState();

  @override
  List<Object> get props => [];
}

class AllUsersListInitial extends AllUsersListState {
  final List<CalcluateEntity> listToshow;

  const AllUsersListInitial({required this.listToshow});
}
