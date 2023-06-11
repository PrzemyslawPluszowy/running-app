import 'package:equatable/equatable.dart';

abstract class AuthCubitState extends Equatable {
  @override
  List<Object?> get props => [];
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
  @override
  List<Object?> get props => [];
}

class IsLogOutState extends AuthCubitState {
  @override
  List<Object?> get props => [];
}
