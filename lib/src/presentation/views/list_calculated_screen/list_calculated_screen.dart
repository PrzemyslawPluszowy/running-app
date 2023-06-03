import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/src/core/ext/extension.dart';
import 'package:new_app/src/domain/entities/user_entity.dart';
import 'package:new_app/src/presentation/cubits/list_race_calulated/list_race_calculated_cubit.dart';
import 'package:new_app/src/presentation/widgets/vdot_circle_widget.dart';

class ListCalutedCrean extends StatefulWidget {
  const ListCalutedCrean({super.key, required this.userData});
  final UserEntity userData;

  @override
  State<ListCalutedCrean> createState() => _ListCalutedCreanState();
}

class _ListCalutedCreanState extends State<ListCalutedCrean> {
  @override
  void initState() {
    context.read<ListRaceCalculatedCubit>().showCurretRaceList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListRaceCalculatedCubit, ListRaceCalculatedState>(
        builder: (context, state) {
      if (state is ListRaceCalculatedLoaded) {
        var listOfcalulated = state.listUserRace;
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
                              width: 60,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                    right: 5,
                    top: 0,
                    child: SizedBox(
                      child: IconButton(
                          onPressed: () {
                            context
                                .read<ListRaceCalculatedCubit>()
                                .deleteSingleCalculatedPost(
                                    state.listUserRace[index].id!);
                            print(state.listUserRace[index].id);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).colorScheme.error,
                          )),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: SizedBox(
                        width: 100,
                        height: 100,
                        child: VdotVircleWidget(
                            vdot: listOfcalulated[index].vdot)),
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
