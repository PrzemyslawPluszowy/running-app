part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadedState extends UserState {
  final UserEntity loggedUser;

  const UserLoadedState({required this.loggedUser});
  @override
  List<Object?> get props => [loggedUser];
}

class UserErrorState extends UserState {
  @override
  List<Object?> get props => [];
}
