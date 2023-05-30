import 'package:go_router/go_router.dart';

import 'package:new_app/src/presentation/views/login_screen/login_screen.dart';
import 'package:new_app/src/presentation/views/main_screan/main_screen.dart';
import 'package:new_app/src/presentation/views/register_screen/register_screen.dart';
import 'package:new_app/src/presentation/widgets/is_login_screen.dart';

class RouteConfig {
  RouteConfig();

  static returnRouter(bool isAuth) {
    GoRouter router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const IsLoginScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/main/:uid',
          builder: (context, state) {
            final query = state.queryParameters['uid']; // may be null

            return MainScreen(uid: query!);
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
