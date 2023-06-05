part of 'all_users_list_cubit.dart';

abstract class AllUsersListState extends Equatable {
  const AllUsersListState();

  @override
  List<Object> get props => [];
}

class AllUsersListInitial extends AllUsersListState {}

class AllUsersListLoaded extends AllUsersListState {
  final List<CalcluateEntity> listToshow;

  const AllUsersListLoaded({required this.listToshow});
}

class AllUsersListLoading extends AllUsersListState {}
