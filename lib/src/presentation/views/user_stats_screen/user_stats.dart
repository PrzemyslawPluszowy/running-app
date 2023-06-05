import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/src/domain/entities/user_entity.dart';
import 'package:new_app/src/presentation/cubits/UserStats/user_stats_cubit.dart';
import 'package:new_app/src/presentation/widgets/avatar_circle_global_widget.dart';
import 'package:new_app/src/presentation/widgets/avatar_image.dart';
import 'package:new_app/src/presentation/widgets/vdot_circle_widget.dart';

import '../../widgets/circle_vdot_with_progres.dart';

class UserStatsScreen extends StatelessWidget {
  const UserStatsScreen({super.key, required this.userData});
  final UserEntity userData;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatarGlobalWidget(imageUrl: userData.urlImageAvatar!),
            BlocBuilder<UserStatsCubit, UserStatsState>(
              builder: (context, state) {
                if (state is UserStatsLoaded) {
                  return Text(state.listOfvdot.toString());
                } else {
                  return Text('Loading');
                }
              },
            ),
            // CircleProgrssWidget(
            //     value: userData.vdot?.toDouble(),
            //     maxValue: 85,
            //     minValue: 30,
            //     title: 'Your',
            //     subtitle: 'vDot'),
            CircleProgrssWidget(
                value: userData.bmi?.toDouble(),
                maxValue: 50,
                minValue: 15,
                title: 'Your',
                subtitle: 'BMI'),
            OutlinedButton(
                onPressed: () {
                  context.read<UserStatsCubit>().showUserStats();
                },
                child: Text('Edit')),
          ],
        ),
      ),
    );
  }
}
