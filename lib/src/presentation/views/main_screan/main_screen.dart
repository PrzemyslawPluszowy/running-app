import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/src/domain/entities/user_entity.dart';
import 'package:new_app/src/presentation/cubits/user/user_cubit.dart';
import 'package:new_app/src/presentation/views/calculator_screen/calculator_screen.dart';
import 'package:new_app/src/presentation/views/list_calculated_screen/list_calculated_screen.dart';
import 'package:new_app/src/presentation/views/main_screan/widgets/custom_app_bar_widget.dart';
import 'package:new_app/src/presentation/views/user_stats_screen/user_stats.dart';

import '../../cubits/bootom_navigation/page_view_bootom_n_avigation_cubit.dart';
import '../all_users_list_screen/all_users_list_screen.dart';
import '../setting_screen/setting_screen.dart';
import 'widgets/custom_navigation_bar_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });
  // final String uid;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late UserEntity loggedUser;
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController();
    context.read<UserCubit>().getCurretUser();

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void changePage(int index) {
    _pageController.animateToPage(index,
        curve: Curves.easeIn, duration: const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
      if (state is UserInitial || state is UserLoadingState) {
        context.read<UserCubit>().getCurretUser();
      }
    }, builder: (context, state) {
      if (state is UserLoadingState) {
        return const SafeArea(
            child: Center(
          child: CircularProgressIndicator(),
        ));
      }
      if (state is UserLoadedState) {
        return returnBody(state.loggedUser);
      }
      if (state is UserLoadingState) {
        return const LinearProgressIndicator();
      }
      return const Center(child: Text('error'));
    });
  }

  Widget returnBody(UserEntity loggedUser) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      bottomNavigationBar: const CustomNavigationBar(),
      body: Column(
        children: [
          customAppBar(loggedUser, context),
          BlocListener<PageViewBootomNavigationCubit,
              PageViewBootomNavigationState>(
            listener: (context, state) {
              if (state is PageViewIndex) {
                changePage(state.index);
              }
            },
            child: Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                child: PageView(
                    allowImplicitScrolling: true,
                    controller: _pageController,
                    children: [
                      CalculatorScreen(
                        userData: loggedUser,
                      ),
                      UserStatsScreen(userData: loggedUser),
                      const AllUserCalculatedListScreen(),
                      ListCalutedCrean(
                        userData: loggedUser,
                      ),
                      SettingScreen(
                        user: loggedUser,
                      ),
                    ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
