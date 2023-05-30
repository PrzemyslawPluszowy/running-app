import 'package:equatable/equatable.dart';

abstract class AuthCubitState extends Equatable {
  const AuthCubitState();
}

class AuthCubitInitial extends AuthCubitState {
  @override
  List<Object?> get props => [];
}

class AuthCubitLoading extends AuthCubitState {
  @override
  List<Object?> get props => [];
}

class AuthCubiLoaded extends AuthCubitState {
  @override
  List<Object?> get props => [];
}

class AuthCubitError extends AuthCubitState {
  final String error;

  const AuthCubitError({required this.error});
  @override
  List<Object?> get props => [error];
}

class IsLogInState extends AuthCubitState {
  final String userUrid;

  const IsLogInState({required this.userUrid});
  @override
  List<Object?> get props => [userUrid];
}

class IsLogOutState extends AuthCubitState {
  @override
  List<Object?> get props => [];
}
