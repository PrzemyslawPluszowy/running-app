import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/src/presentation/cubits/auth/auth_cubit_cubit.dart';
import 'package:new_app/src/presentation/cubits/auth/auth_cubit_state.dart';

import '../views/login_screen/login_screen.dart';
import '../views/main_screan/main_screen.dart';

class IsLoginScreen extends StatelessWidget {
  const IsLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthCubitState>(builder: (context, state) {
      if (state is IsLogInState) {
        return MainScreen(
          uid: state.userUrid,
        );
      }
      if (state is IsLogOutState) {
        return const LoginScreen();
      }
      return LoginScreen();
    });
  }
}
