import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/src/core/ext/extension.dart';
import 'package:new_app/src/presentation/cubits/calculator/calculator_cubit.dart';

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
    String initPace = context.read<CalculatorCubit>().pace.toStoper();
    _paceTimeTextController = TextEditingController(text: initPace);
    _pickMinutesController = FixedExtentScrollController();
    _pickSecondsController = FixedExtentScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _pickMinutesController.dispose();
    _pickSecondsController.dispose();
    _paceTimeTextController.dispose();
    super.dispose();
  }

  late FixedExtentScrollController _pickMinutesController;
  late FixedExtentScrollController _pickSecondsController;
  late TextEditingController _paceTimeTextController;

  final List<int> minutesCupertinoList = List.generate(60, (index) => index);
  final List<int> secandsCupertinoList = List.generate(60, (index) => index);

  int _minutes = 0;
  int _seconds = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalculatorCubit, CalculatorState>(
      listener: (context, state) {
        if (state is CalculatorInitial) {
          _minutes = state.pace.inMinutes.remainder(60);
          _seconds = state.pace.inSeconds.remainder(60);
          _pickMinutesController =
              FixedExtentScrollController(initialItem: _minutes);
          _pickSecondsController =
              FixedExtentScrollController(initialItem: _seconds);
          _paceTimeTextController =
              TextEditingController(text: state.pace.toStoper());
        }
        if (state is CalculatorController) {
          _minutes = state.pace.inMinutes.remainder(60);
          _seconds = state.pace.inSeconds.remainder(60);
          _pickMinutesController =
              FixedExtentScrollController(initialItem: _minutes);
          _pickSecondsController =
              FixedExtentScrollController(initialItem: _seconds);
          _paceTimeTextController =
              TextEditingController(text: state.pace.toStoper());
        }
      },
      child: TextField(
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .merge(TextStyle(color: Theme.of(context).colorScheme.primary)),
        controller: _paceTimeTextController,
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

  void _initValueInState(state) {
    _minutes = state.pace.inMinutes.remainder(60);
    _seconds = state.pace.inSeconds.remainder(60);
    _pickMinutesController = FixedExtentScrollController(initialItem: _minutes);
    _pickSecondsController = FixedExtentScrollController(initialItem: _seconds);
    _paceTimeTextController =
        TextEditingController(text: state.pace.toStoper());
  }

  Future<void> _paceTimeDialogPicker({required BuildContext context}) async {
    _pickMinutesController = FixedExtentScrollController(initialItem: _minutes);
    _pickSecondsController = FixedExtentScrollController(initialItem: _seconds);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    context
                        .read<CalculatorCubit>()
                        .setingPaceTime(minutes: _minutes, seconds: _seconds);

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
                            _minutes = value;
                            context.read<CalculatorCubit>().setingPaceTime(
                                minutes: _minutes, seconds: _seconds);
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

                            context.read<CalculatorCubit>().setingPaceTime(
                                minutes: _minutes, seconds: _seconds);
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
