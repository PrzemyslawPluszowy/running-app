import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/src/data/repositories/calculator_repo_impl.dart';
import 'package:new_app/src/presentation/cubits/calculator/calculator_cubit.dart';

import '../../../../utils/global_method/global_method.dart';

class CustomDistanceFieldState extends StatefulWidget {
  const CustomDistanceFieldState({
    super.key,
    required this.colorScheme,
    required this.labelText,
  });

  final ColorScheme colorScheme;
  final String labelText;

  @override
  State<CustomDistanceFieldState> createState() => _CustomDistanceFieldState();
}

class _CustomDistanceFieldState extends State<CustomDistanceFieldState> {
  @override
  void initState() {
    _paceTime = TextEditingController(
        text: durationToString(RunningCalculatorImpl().pace));
    _pickKmController = FixedExtentScrollController();
    _pickMetersController = FixedExtentScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _pickKmController.dispose();
    _pickMetersController.dispose();
    _paceTime.dispose();
    super.dispose();
  }

  late FixedExtentScrollController _pickKmController;
  late FixedExtentScrollController _pickMetersController;

  late TextEditingController _paceTime;

  final List<int> _kmList = List.generate(60, (index) => index);
  final List<int> _metersCupertinoList =
      List.generate(10, (index) => index * 100);

  int km = 0;
  int meters = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalculatorCubit, CalculatorState>(
      listener: (context, state) {
        if (state is CalculatorController) {}
      },
      child: TextField(
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .merge(TextStyle(color: Theme.of(context).colorScheme.primary)),
        controller: _paceTime,
        minLines: 1,
        maxLines: 1,
        showCursor: false,
        onTap: () async {
          FocusScope.of(context).unfocus();

          await _customDistanceDialogPicker(context: context);
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

  Future<void> _customDistanceDialogPicker(
      {required BuildContext context}) async {
    _pickKmController = FixedExtentScrollController(initialItem: km);
    _pickMetersController = FixedExtentScrollController(initialItem: meters);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    context
                        .read<CalculatorCubit>()
                        .setDistance(meters: (additionKMandMeters(meters, km)));
                    context.pop();
                  },
                  child: const Text('Set your distance'))
            ],
            title: const Text("Pick"),
            content: SizedBox(
              height: 200,
              width: 300,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CupertinoPicker(
                          scrollController: _pickKmController,
                          magnification: 1.22,
                          squeeze: 1.2,
                          useMagnifier: true,
                          itemExtent: 50,
                          onSelectedItemChanged: (value) {
                            km = value;
                          },
                          children: _kmList
                              .map((e) => Center(child: Text('$e')))
                              .toList()),
                    ),
                    const Text('km'),
                    Expanded(
                      child: CupertinoPicker(
                          scrollController: _pickMetersController,
                          magnification: 1.22,
                          squeeze: 1.2,
                          useMagnifier: true,
                          itemExtent: 50,
                          onSelectedItemChanged: (value) {
                            meters = value;
                          },
                          children: _metersCupertinoList
                              .map((e) => Center(child: Text('$e')))
                              .toList()),
                    ),
                    const Text('meters')
                  ],
                ),
              ),
            ));
      },
    );
  }

  double additionKMandMeters(int meter, int km) {
    return km + (meters * 0.1);
  }
}
