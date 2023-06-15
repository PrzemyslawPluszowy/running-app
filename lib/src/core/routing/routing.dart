import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/src/presentation/cubits/auth/auth_cubit_cubit.dart';
import 'package:new_app/src/presentation/cubits/auth/auth_cubit_state.dart';

import 'package:new_app/src/presentation/views/login_screen/login_screen.dart';
import 'package:new_app/src/presentation/views/main_screan/main_screen.dart';
import 'package:new_app/src/presentation/views/register_screen/register_screen.dart';

class RouteConfig {
  static returnRouter() {
    GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => BlocBuilder<AuthCubit, AuthCubitState>(
            builder: (context, state) {
              if (state is IsLogInState) {
                return const MainScreen();
              }
              if (state is IsLogOutState) {
                return const LoginScreen();
              }
              return const LoginScreen();
            },
          ),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/main',
          builder: (context, state) {
            // final query = state.queryParameters['uid']; // may be null

            return const MainScreen();
          },
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
      ],
    );

    return router;
  }
}
