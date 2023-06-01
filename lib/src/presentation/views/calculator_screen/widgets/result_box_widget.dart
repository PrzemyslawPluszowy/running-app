import 'package:flutter/material.dart';

class ResultBoxWidget extends StatelessWidget {
  const ResultBoxWidget({super.key, this.state});
  final state;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
          color: colorScheme.primary, borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          circleVdot(context, state),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.add_road_sharp),
                      title: Text(
                          '${state.resultRaceWithVdot.distance / 1000} km'),
                      subtitle: const Text('Distance'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.watch_later_outlined),
                      title: Text(
                          '${state.resultRaceWithVdot.timeRace.inHours}:${state.resultRaceWithVdot.timeRace.inMinutes.remainder(60)}:${state.resultRaceWithVdot.timeRace.inSeconds.remainder(60)}'),
                      subtitle: const Text('Time Race'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.add_road_sharp),
                      title: Text(
                          '${state.resultRaceWithVdot.pace.inMinutes}:${state.resultRaceWithVdot.pace.inSeconds.remainder(60)}'),
                      subtitle: const Text('Pace'),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding circleVdot(BuildContext context, state) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 130,
        width: 130,
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 4, blurStyle: BlurStyle.normal)],
          gradient: LinearGradient(begin: Alignment(0.2, 2), colors: [
            Color.fromARGB(255, 242, 244, 242),
            Color.fromARGB(255, 229, 229, 234),
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 109, 44, 239)
          ]),
          shape: BoxShape.circle,
        ),
        child: Padding(
          //this padding will be you border size
          padding: const EdgeInsets.all(7.0),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Your ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text('Vdot is:',
                      style: Theme.of(context).textTheme.bodySmall),
                  Text(
                    '${state.resultRaceWithVdot.vdot}',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
