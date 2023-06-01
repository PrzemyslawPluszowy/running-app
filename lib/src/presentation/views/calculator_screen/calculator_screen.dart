import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/src/presentation/cubits/calculator/calculator_cubit.dart';
import 'package:new_app/src/presentation/views/calculator_screen/widgets/distance_field_picker.dart';
import 'package:new_app/src/presentation/views/calculator_screen/widgets/pace_time_field_picker.dart';
import 'package:new_app/src/presentation/views/calculator_screen/widgets/race_time_field_picker.dart';
import 'package:new_app/src/presentation/views/calculator_screen/widgets/result_box_widget.dart';
import 'package:new_app/src/presentation/widgets/avatar_image.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      child: BlocConsumer<CalculatorCubit, CalculatorState>(
        listener: (context, state) {
          if (state is CalcResultError) {
            _showVdotError(state);
          }
        },
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                DistanceFieldWidget(
                    colorScheme: colorScheme, labelText: 'Distance'),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 5,
                        child: RaceTimeFieldState(
                          colorScheme: colorScheme,
                          labelText: "Race Time",
                        ),
                      ),
                      state is CalcResultError
                          ? Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Icon(
                                  Icons.error_outline,
                                  size: 50,
                                  color: colorScheme.error,
                                )),
                              ))
                          : const SizedBox(),
                    ],
                  ),
                ),
                PaceTimeFieldState(colorScheme: colorScheme, labelText: 'pace'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: OutlinedButton.icon(
                          onPressed: () {
                            context.read<CalculatorCubit>().setVdot();
                          },
                          icon: const Icon(Icons.add_task_sharp),
                          label: const Text('Calculate Vdot')),
                    ),
                    state is CalcResultSuccces
                        ? OutlinedButton.icon(
                            style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all(
                                    colorScheme.onPrimary),
                                textStyle: MaterialStateProperty.all(
                                    TextStyle(color: colorScheme.onPrimary)),
                                backgroundColor: MaterialStateProperty.all(
                                    colorScheme.primary)),
                            onPressed: () {
                              context.read<CalculatorCubit>().setVdot();
                            },
                            icon: const Icon(Icons.save_as_outlined),
                            label: const Text('Save your result'))
                        : const SizedBox(
                            width: 0,
                          ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                state is CalcResultSuccces
                    ? ResultBoxWidget(
                        state: state,
                      )
                    : const SizedBox()
              ]));
        },
      ),
    );
  }

  _showVdotError(state) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          content: SizedBox(
            width: 200,
            height: 200,
            child: Center(
              child: Text(state.error),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.close))
          ]),
    );
  }
}
