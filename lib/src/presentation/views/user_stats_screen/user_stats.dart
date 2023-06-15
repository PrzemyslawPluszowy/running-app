import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/src/core/ext/extension.dart';
import 'package:new_app/src/domain/entities/user_entity.dart';
import 'package:new_app/src/presentation/cubits/UserStats/user_stats_cubit.dart';
import 'package:new_app/src/presentation/widgets/avatar_circle_global_widget.dart';

import '../../widgets/circle_vdot_with_progres.dart';

class VdotList {
  final int index;
  final int vdot;

  VdotList({required this.index, required this.vdot});
}

class UserStatsScreen extends StatelessWidget {
  const UserStatsScreen({super.key, required this.userData});
  final UserEntity userData;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserStatsCubit, UserStatsState>(
      builder: (context, state) {
        if (state is UserStatsInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is UserStatsError) {
          return const Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Plese calculate your vdot first"),
              Icon(Icons.watch_rounded, size: 100),
            ],
          ));
        }
        if (state is UserStatsLoaded) {
          List<VdotList> points = List.generate(state.vdotList.length,
              (index) => VdotList(index: index, vdot: state.vdotList[index]));

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatarGlobalWidget(
                          imageUrl: userData.urlImageAvatar!),
                      CircleProgrssWidget(
                          value: state.vdot.toDouble(),
                          maxValue: 85,
                          minValue: 30,
                          title: 'Your',
                          subtitle: 'vdot'),
                      CircleProgrssWidget(
                          value: state.bmi.toDouble(),
                          maxValue: 50,
                          minValue: 15,
                          title: 'Your',
                          subtitle: 'BMI'),
                      CircleProgrssWidget(
                          value: state.avgVdot.toDouble(),
                          maxValue: 85,
                          minValue: 30,
                          title: 'Your',
                          subtitle: 'avg vdot'),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  hrZoneCardWidget(state, context),
                  estimatedRaceTimeWidget(state, context),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: Stack(children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LineChart(
                            curve: Curves.linear,
                            LineChartData(
                              titlesData: const FlTitlesData(
                                show: false,
                              ),
                              borderData: FlBorderData(show: false),
                              lineBarsData: [
                                LineChartBarData(
                                  gradient: LinearGradient(colors: [
                                    Theme.of(context).colorScheme.primary,
                                    Theme.of(context).colorScheme.secondary
                                  ]),
                                  color: Theme.of(context).colorScheme.primary,
                                  spots: points
                                      .map((point) => FlSpot(
                                          point.index.toDouble(),
                                          point.vdot.toDouble()))
                                      .toList(),
                                  isCurved: true,
                                  dotData: const FlDotData(
                                    show: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 10,
                        top: 10,
                        child: SizedBox(
                          width: 150,
                          height: 150,
                          child: Text('Progress by vdot'),
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Text('Loading');
        }
      },
    );
  }

  Card estimatedRaceTimeWidget(UserStatsLoaded state, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estimated race times from: vdot ${state.vdot}',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Table(
                children: [
                  TableRow(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Theme.of(context).colorScheme.primary),
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Distance',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Time',
                              textAlign: TextAlign.right,
                              style: TextStyle(color: Colors.white)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Pace',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ]),
                  TableRow(children: [
                    Text('Marathon',
                        style: Theme.of(context)
                            .textTheme
                            .copyWith(
                                labelLarge: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor))
                            .labelLarge),
                    Text(
                      state.marathonTime.toStoper(),
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      state.marathonTime.toPace(42195).toStoper(),
                      textAlign: TextAlign.center,
                    )
                  ]),
                  TableRow(children: [
                    Text('Half-Marathon',
                        style: Theme.of(context)
                            .textTheme
                            .copyWith(
                                labelLarge: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor))
                            .labelLarge),
                    Text(
                      state.halfMarathonTime.toStoper(),
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      state.halfMarathonTime.toPace(42195).toStoper(),
                      textAlign: TextAlign.center,
                    )
                  ]),
                  TableRow(children: [
                    Text('15 km',
                        style: Theme.of(context)
                            .textTheme
                            .copyWith(
                                labelLarge: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor))
                            .labelLarge),
                    Text(state.m15km.toStoper(), textAlign: TextAlign.right),
                    Text(state.m15km.toPace(42195).toStoper(),
                        textAlign: TextAlign.center)
                  ]),
                  TableRow(children: [
                    Text('10 km',
                        style: Theme.of(context)
                            .textTheme
                            .copyWith(
                                labelLarge: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor))
                            .labelLarge),
                    Text(state.tenKmTime.toStoper(),
                        textAlign: TextAlign.right),
                    Text(state.tenKmTime.toPace(10000).toStoper(),
                        textAlign: TextAlign.center)
                  ]),
                  TableRow(children: [
                    Text('5 km',
                        style: Theme.of(context)
                            .textTheme
                            .copyWith(
                                labelLarge: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor))
                            .labelLarge),
                    Text(state.fiveKmTime.toStoper(),
                        textAlign: TextAlign.right),
                    Text(state.fiveKmTime.toPace(5000).toStoper(),
                        textAlign: TextAlign.center)
                  ]),
                  TableRow(children: [
                    Text('2 mile',
                        style: Theme.of(context)
                            .textTheme
                            .copyWith(
                                labelLarge: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor))
                            .labelLarge),
                    Text(
                      state.m3200.toStoper(),
                      textAlign: TextAlign.right,
                    ),
                    Text(state.m3200.toPace(3218).toStoper(),
                        textAlign: TextAlign.center)
                  ]),
                  TableRow(children: [
                    Text('1500 m',
                        style: Theme.of(context)
                            .textTheme
                            .copyWith(
                                labelLarge: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor))
                            .labelLarge),
                    Text(state.m1500.toStoper(), textAlign: TextAlign.right),
                    Text(state.m1500.toPace(1500).toStoper(),
                        textAlign: TextAlign.center)
                  ]),
                  TableRow(children: [
                    Text('1 mile',
                        style: Theme.of(context)
                            .textTheme
                            .copyWith(
                                labelLarge: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor))
                            .labelLarge),
                    Text(state.m1600.toStoper(), textAlign: TextAlign.right),
                    Text(state.m1600.toPace(1609).toStoper(),
                        textAlign: TextAlign.center)
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card hrZoneCardWidget(UserStatsLoaded state, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calculated from your last Vdot: ${state.vdot}',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Table(
                children: [
                  TableRow(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Theme.of(context).colorScheme.primary),
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Your Traning Pace',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('1km',
                              style: TextStyle(color: Colors.white)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Hr Zone',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ]),
                  TableRow(children: [
                    const Text('Easy', style: TextStyle(color: Colors.blue)),
                    Text(state.marathonPace.toStoper(),
                        style: const TextStyle(color: Colors.blue)),
                    Text('${state.easyZoneMin}-${state.easyZoneMax}',
                        style: const TextStyle(color: Colors.blue)),
                  ]),
                  TableRow(children: [
                    const Text('Marathon',
                        style: TextStyle(color: Colors.green)),
                    Text(state.easyPace.toStoper(),
                        style: const TextStyle(color: Colors.green)),
                    Text('${state.marathonZoneMin}-${state.marathonZoneMax}',
                        style: const TextStyle(color: Colors.green)),
                  ]),
                  TableRow(children: [
                    const Text('Threshold',
                        style: TextStyle(color: Colors.orange)),
                    Text(state.thresholdPace.toStoper(),
                        style: const TextStyle(color: Colors.orange)),
                    Text('${state.thresholdZoneMin}-${state.thresholdZoneMax}',
                        style: const TextStyle(color: Colors.orange)),
                  ]),
                  TableRow(children: [
                    const Text('Interval', style: TextStyle(color: Colors.red)),
                    Text(state.intervalPace.toStoper(),
                        style: const TextStyle(color: Colors.red)),
                    Text(
                      '${state.intervalZoneMin}-${state.intervalZoneMax}',
                      style: const TextStyle(color: Colors.red),
                    )
                  ]),
                  TableRow(children: [
                    const Text('Repetition',
                        style:
                            TextStyle(color: Color.fromARGB(255, 255, 0, 0))),
                    Text(state.repetitionPace.toStoper(),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0))),
                    Text(
                        '${state.repetitionZoneMin}-${state.repetitionZoneMax}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0))),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
