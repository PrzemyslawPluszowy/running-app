import 'package:flutter/material.dart';
import 'package:new_app/src/presentation/views/calculator_screen/widgets/distance_field_picker.dart';
import 'package:new_app/src/presentation/views/calculator_screen/widgets/pace_time_field_picker.dart';
import 'package:new_app/src/presentation/views/calculator_screen/widgets/race_time_field_picker.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          DistanceFieldWidget(colorScheme: colorScheme, labelText: 'Distance'),
          RaceTimeFieldState(
            colorScheme: colorScheme,
            labelText: "Race Time",
          ),
          PaceTimeFieldState(colorScheme: colorScheme, labelText: 'pace'),
          OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_task_sharp),
              label: const Text('Calculate Vdot')),
        ]),
      ),
    );
  }
}
