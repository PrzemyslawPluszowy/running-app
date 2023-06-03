import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/src/data/repositories/calculator_repo_impl.dart';
import 'package:new_app/src/presentation/cubits/calculator/calculator_cubit.dart';

import '../../../../core/global_method/global_method.dart';

class PaceTimeFieldState extends StatefulWidget {
  const PaceTimeFieldState({
    super.key,
    required this.colorScheme,
    required this.labelText,
  });

  final ColorScheme colorScheme;
  final String labelText;

  @override
  State<PaceTimeFieldState> createState() => _PaceTimeFieldState();
}

class _PaceTimeFieldState extends State<PaceTimeFieldState> {
  @override
  void initState() {
    _paceTime = TextEditingController(
        text: durationToString(RunningCalculatorImpl().pace));
    _pickMinutesController = FixedExtentScrollController();
    _pickSecondsController = FixedExtentScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _pickMinutesController.dispose();
    _pickSecondsController.dispose();
    _paceTime.dispose();
    super.dispose();
  }

  late FixedExtentScrollController _pickMinutesController;
  late FixedExtentScrollController _pickSecondsController;

  late TextEditingController _paceTime;

  final List<int> minutesCupertinoList = List.generate(60, (index) => index);
  final List<int> secandsCupertinoList = List.generate(60, (index) => index);

  int minutes = 0;
  int seconds = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalculatorCubit, CalculatorState>(
      listener: (context, state) {
        if (state is CalculatorController) {
          _paceTime.text = durationToString(state.pace);
          minutes = state.pace.inMinutes.remainder(60);
          seconds = state.pace.inSeconds.remainder(60);
        }
      },
      child: TextField(
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .merge(TextStyle(color: Theme.of(context).colorScheme.primary)),
        controller: _paceTime,
        minLines: 1,
        maxLines: 1,
        showCursor: false,
        onTap: () async {
          FocusScope.of(context).unfocus();

          await _paceTimeDialogPicker(context: context);
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
          prefixIcon: const Icon(Icons.route_outlined),
          helperText: '',
        ),
      ),
    );
  }

  Future<void> _paceTimeDialogPicker({required BuildContext context}) async {
    _pickMinutesController = FixedExtentScrollController(initialItem: minutes);
    _pickSecondsController = FixedExtentScrollController(initialItem: seconds);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    context
                        .read<CalculatorCubit>()
                        .setPaceTime(minutes: minutes, seconds: seconds);

                    context.pop();
                  },
                  child: const Text('Set pace'))
            ],
            title: const Text("Pick your pace"),
            content: SizedBox(
              height: 150,
              width: 300,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CupertinoPicker(
                          scrollController: _pickMinutesController,
                          magnification: 1.22,
                          squeeze: 1.2,
                          useMagnifier: true,
                          itemExtent: 50,
                          onSelectedItemChanged: (value) {
                            minutes = value;
                            context
                                .read<CalculatorCubit>()
                                .setPaceTime(minutes: value, seconds: seconds);
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
                            seconds = value;

                            context
                                .read<CalculatorCubit>()
                                .setPaceTime(minutes: minutes, seconds: value);
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
