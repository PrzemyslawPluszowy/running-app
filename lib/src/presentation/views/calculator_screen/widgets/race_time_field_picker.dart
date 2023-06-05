import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/src/core/ext/extension.dart';
import 'package:new_app/src/presentation/cubits/calculator/calculator_cubit.dart';

class RaceTimeFieldState extends StatefulWidget {
  const RaceTimeFieldState({
    super.key,
    required this.colorScheme,
    required this.labelText,
  });

  final ColorScheme colorScheme;
  final String labelText;

  @override
  State<RaceTimeFieldState> createState() => _RaceTimeFieldState();
}

class _RaceTimeFieldState extends State<RaceTimeFieldState> {
  @override
  void initState() {
    String initRaceText = context.read<CalculatorCubit>().timeRace.toStoper();

    _raceTimeTextController = TextEditingController(text: initRaceText);
    _pickHoursController = FixedExtentScrollController();
    _pickMinutesController = FixedExtentScrollController();
    _pickSecondsController = FixedExtentScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _pickMinutesController.dispose();
    _pickHoursController.dispose();
    _pickSecondsController.dispose();
    _raceTimeTextController.dispose();
    super.dispose();
  }

  late FixedExtentScrollController _pickHoursController;
  late FixedExtentScrollController _pickMinutesController;
  late FixedExtentScrollController _pickSecondsController;

  late TextEditingController _raceTimeTextController;

  final List<int> hoursCupertinoList = List.generate(100, (index) => index);
  final List<int> minutesCupertinoList = List.generate(60, (index) => index);
  final List<int> secandsCupertinoList = List.generate(60, (index) => index);

  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalculatorCubit, CalculatorState>(
      listener: (context, state) {
        if (state is CalculatorInitial) {
          _hours = state.timeRace.inHours;
          _minutes = state.timeRace.inMinutes.remainder(60);
          _seconds = state.timeRace.inSeconds.remainder(60);
          _pickMinutesController =
              FixedExtentScrollController(initialItem: _minutes);
          _pickSecondsController =
              FixedExtentScrollController(initialItem: _seconds);
          _raceTimeTextController =
              TextEditingController(text: state.pace.toStoper());
        }
        if (state is CalculatorController) {
          _hours = state.timeRace.inHours;
          _minutes = state.timeRace.inMinutes.remainder(60);
          _seconds = state.timeRace.inSeconds.remainder(60);
          _pickMinutesController =
              FixedExtentScrollController(initialItem: _minutes);
          _pickSecondsController =
              FixedExtentScrollController(initialItem: _seconds);
          _raceTimeTextController =
              TextEditingController(text: state.timeRace.toStoper());
        }
      },
      child: TextField(
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .merge(TextStyle(color: Theme.of(context).colorScheme.primary)),
        controller: _raceTimeTextController,
        minLines: 1,
        maxLines: 1,
        showCursor: false,
        onTap: () async {
          FocusScope.of(context).unfocus();

          await _raceTimeDialogPicker(context: context);
        },
        keyboardType: TextInputType.name,
        enableInteractiveSelection: true,
        autofocus: false,
        readOnly: true,
        focusNode: FocusNode(
            descendantsAreTraversable: false,
            canRequestFocus: false,
            descendantsAreFocusable: false,
            skipTraversal: true),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: widget.colorScheme.primary)),
          fillColor: widget.colorScheme.inversePrimary,
          filled: true,
          isDense: true,
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: widget.labelText,
          prefixIcon: const Icon(Icons.timer),
          helperText: '',
        ),
      ),
    );
  }

  Future<void> _raceTimeDialogPicker({required BuildContext context}) async {
    _pickMinutesController = FixedExtentScrollController(initialItem: _minutes);
    _pickHoursController = FixedExtentScrollController(initialItem: _hours);
    _pickSecondsController = FixedExtentScrollController(initialItem: _seconds);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    context.read<CalculatorCubit>().settingRaceTime(
                        hours: _hours, minutes: _minutes, seconds: _seconds);

                    context.pop();
                  },
                  child: const Text('Set time'))
            ],
            title: const Text("Pick the time"),
            content: SizedBox(
              height: 200,
              width: 300,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CupertinoPicker(
                          looping: true,
                          scrollController: _pickHoursController,
                          magnification: 1.22,
                          squeeze: 1.2,
                          useMagnifier: true,
                          itemExtent: 50,
                          onSelectedItemChanged: (value) {
                            _hours = value;

                            context.read<CalculatorCubit>().settingRaceTime(
                                hours: value,
                                minutes: _minutes,
                                seconds: _seconds);
                          },
                          children: hoursCupertinoList
                              .map((e) => Center(child: Text('$e')))
                              .toList()),
                    ),
                    const Text('h'),
                    Expanded(
                      child: CupertinoPicker(
                          scrollController: _pickMinutesController,
                          magnification: 1.22,
                          squeeze: 1.2,
                          useMagnifier: true,
                          itemExtent: 50,
                          onSelectedItemChanged: (value) {
                            _minutes = value;
                            context.read<CalculatorCubit>().settingRaceTime(
                                hours: _hours,
                                minutes: value,
                                seconds: _seconds);
                          },
                          children: minutesCupertinoList
                              .map((e) => Center(child: Text('$e')))
                              .toList()),
                    ),
                    const Text('m'),
                    Expanded(
                      child: CupertinoPicker(
                          scrollController: _pickSecondsController,
                          magnification: 1.22,
                          squeeze: 1.2,
                          useMagnifier: true,
                          itemExtent: 50,
                          onSelectedItemChanged: (value) {
                            _seconds = value;
                            context
                                .read<CalculatorCubit>()
                                .settingRaceTime(seconds: value);
                            context.read<CalculatorCubit>().settingRaceTime(
                                hours: _hours,
                                minutes: _minutes,
                                seconds: value);
                          },
                          children: secandsCupertinoList
                              .map((e) => Center(child: Text('$e')))
                              .toList()),
                    ),
                    const Text('s')
                  ],
                ),
              ),
            ));
      },
    );
  }
}
