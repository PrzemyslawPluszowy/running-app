import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/src/presentation/cubits/UserStats/user_stats_cubit.dart';
import 'package:new_app/src/presentation/cubits/all_users_list/all_users_list_cubit.dart';
import 'package:new_app/src/presentation/cubits/auth/auth_cubit_cubit.dart';
import 'package:new_app/src/presentation/cubits/bootom_navigation/page_view_bootom_n_avigation_cubit.dart';
import 'package:new_app/src/presentation/cubits/calculator/calculator_cubit.dart';
import 'package:new_app/src/presentation/cubits/list_race_calulated/list_race_calculated_cubit.dart';
import 'package:new_app/src/presentation/cubits/setting_page/setting_cubit.dart';
import 'package:new_app/src/presentation/cubits/user/user_cubit.dart';
import 'package:new_app/src/core/routing/routing.dart';

import 'src/core/theme/color_schemes.g.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.getIt<AuthCubit>()..initApp()),
          BlocProvider(
            create: (context) => di.getIt<UserCubit>(),
          ),
          BlocProvider(
              create: (context) => di.getIt<PageViewBootomNavigationCubit>()),
          BlocProvider(
            create: (context) => di.getIt<CalculatorCubit>(),
          ),
          BlocProvider(
              create: (context) =>
                  di.getIt<ListRaceCalculatedCubit>()..showCurretRaceList()),
          BlocProvider(
              create: (context) =>
                  di.getIt<AllUsersListCubit>()..fetchNextPage()),
          BlocProvider(
            create: (context) => di.getIt<UserStatsCubit>()..showUserStats(),
          ),
          BlocProvider(
            create: (context) => di.getIt<SettingCubit>(),
          )
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ),
            fontFamily: GoogleFonts.lato().fontFamily,
          ),
          darkTheme:
              ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
          routerConfig: RouteConfig.returnRouter(),
        ));
  }
}
