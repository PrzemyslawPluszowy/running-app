import 'package:equatable/equatable.dart';

abstract class AuthCubitState extends Equatable {
  @override
  List<Object?> get props => [];
  const AuthCubitState();
}

class AuthCubitInitial extends AuthCubitState {}

class AuthCubitLoading extends AuthCubitState {}

class AuthCubiLoaded extends AuthCubitState {}

class AuthCubitError extends AuthCubitState {
  final String error;

  const AuthCubitError({required this.error});
  @override
  List<Object?> get props => [error];
}

class IsLogInState extends AuthCubitState {}

class IsLogOutState extends AuthCubitState {
  @override
  List<Object?> get props => [];
}
