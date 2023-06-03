import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/src/core/ext/extension.dart';
import 'package:new_app/src/presentation/cubits/all_users_list/all_users_list_cubit.dart';
import 'package:new_app/src/presentation/widgets/avatar_circle_global_widget.dart';
import 'package:new_app/src/presentation/widgets/vdot_circle_widget.dart';

class AllUserCalculatedListScreen extends StatelessWidget {
  const AllUserCalculatedListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllUsersListCubit, AllUsersListState>(
        builder: (context, state) {
      if (state is AllUsersListInitial) {
        var listOfcalulated = state.listToshow;
        return ListView.builder(
          itemCount: listOfcalulated.length,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, bottom: 7),
                child: Stack(children: [
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 90,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                      child: _richText(
                                          context: context,
                                          index: index,
                                          label: 'Name: ',
                                          text: listOfcalulated[index]
                                              .userName!)),
                                  FittedBox(
                                      child: _richText(
                                          context: context,
                                          index: index,
                                          label: 'Date: ',
                                          text: listOfcalulated[index]
                                              .createdDate!
                                              .dateToString())),
                                  FittedBox(
                                      child: _richText(
                                          context: context,
                                          index: index,
                                          label: 'Distance: ',
                                          text:
                                              '${listOfcalulated[index].distance / 1000} km')),
                                  FittedBox(
                                      child: _richText(
                                          context: context,
                                          index: index,
                                          label: 'Pace: ',
                                          text:
                                              '${listOfcalulated[index].pace.toStoper()} min/km')),
                                  FittedBox(
                                      child: _richText(
                                          context: context,
                                          index: index,
                                          label: 'Time Race: ',
                                          text: listOfcalulated[index]
                                              .timeRace
                                              .toStoper())),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 60,
                    top: 0,
                    bottom: 0,
                    child: SizedBox(
                        width: 90,
                        height: 90,
                        child: VdotVircleWidget(
                            vdot: listOfcalulated[index].vdot)),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: SizedBox(
                        width: 90,
                        height: 90,
                        child: CircleAvatarGlobalWidget(
                            imageUrl: listOfcalulated[index].avatarUrl!)),
                  ),
                ]),
              ),
            );
          },
        );
      }

      return Center(
        child: Text(
          'Something went Wrong',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      );
    });
  }

  RichText _richText({
    required BuildContext context,
    required int index,
    required String label,
    required String text,
  }) {
    return RichText(
      text: TextSpan(
          text: label,
          style:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
          children: [
            TextSpan(
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                text: text)
          ]),
    );
  }
}
