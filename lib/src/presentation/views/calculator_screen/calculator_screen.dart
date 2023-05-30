import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/src/presentation/cubits/calculator/calculator_cubit.dart';
import 'package:new_app/src/presentation/views/calculator_screen/widgets/custom_distance_field.dart';
import 'package:new_app/src/presentation/views/calculator_screen/widgets/distance_field_picker.dart';
import 'package:new_app/src/presentation/views/calculator_screen/widgets/pace_time_field_picker.dart';
import 'package:new_app/src/presentation/views/calculator_screen/widgets/race_time_field_picker.dart';
import 'package:new_app/src/presentation/widgets/custom_text_field.dart';

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
          BlocBuilder<CalculatorCubit, CalculatorState>(
            builder: (context, state) {
              if (state is CalculatorController) {
                if (state.showCustomDistanceField) {
                  return CustomDistanceFieldState(
                      colorScheme: colorScheme, labelText: 'Custom Distance');
                }
              }
              return const SizedBox();
            },
          ),
          RaceTimeFieldState(
            colorScheme: colorScheme,
            labelText: "Race Time",
          ),
          PaceTimeFieldState(colorScheme: colorScheme, labelText: 'pace')
        ]),
      ),
    );
  }
}
