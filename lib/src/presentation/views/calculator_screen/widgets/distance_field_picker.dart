import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/src/domain/entities/calcuate_entity.dart';
import 'package:new_app/src/presentation/cubits/calculator/calculator_cubit.dart';

enum Distance {
  m1500,
  mile1,
  m3000,
  mile2,
  m5000,
  km10,
  km15,
  haflmaraton,
  marathon,
  other
}

class DistanceFieldWidget extends StatefulWidget {
  const DistanceFieldWidget({
    super.key,
    required this.colorScheme,
    required this.labelText,
  });

  final ColorScheme colorScheme;
  final String labelText;

  @override
  State<DistanceFieldWidget> createState() => _DistanceFieldWidgetState();
}

class _DistanceFieldWidgetState extends State<DistanceFieldWidget> {
  late FixedExtentScrollController _pickKmController;
  late FixedExtentScrollController _pickMetersController;

  late TextEditingController _paceTime;

  final List<int> _kmList = List.generate(60, (index) => index);
  final List<int> _metersCupertinoList =
      List.generate(10, (index) => index * 100);
  late CalcluateEntity initVal;
  int km = 0;
  int meters = 0;
  @override
  void initState() {
    _distanceController =
        TextEditingController(text: enumToTitle(_distanceItem));
    _pickKmController = FixedExtentScrollController();
    _pickMetersController = FixedExtentScrollController();
    initVal = context.read<CalculatorCubit>().getInitValue();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  late TextEditingController _distanceController;
  Distance? _distanceItem = Distance.m5000;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalculatorCubit, CalculatorState>(
      listener: (context, state) {
        if (state is CalculatorController) {}
      },
      child: TextField(
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .merge(TextStyle(color: Theme.of(context).colorScheme.primary)),
        controller: _distanceController,
        minLines: 1,
        maxLines: 1,
        showCursor: false,
        onTap: () async {
          _distanceDialogPicker(context: context);
          FocusScope.of(context).unfocus();
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

  Future<void> _distanceDialogPicker({required BuildContext context}) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text("Pick the time"),
            content: SizedBox(
              width: 300,
              child: Center(
                  child: Column(
                children: [
                  RadioListTile<Distance>(
                    title: const Text('1500 m'),
                    groupValue: _distanceItem,
                    value: Distance.m1500,
                    onChanged: (Distance? value) {
                      _selectValueSet(value);
                    },
                  ),
                  RadioListTile<Distance>(
                    title: const Text('1 miles'),
                    groupValue: _distanceItem,
                    value: Distance.mile1,
                    onChanged: (Distance? value) {},
                  ),
                  RadioListTile<Distance>(
                      title: const Text('3km'),
                      groupValue: _distanceItem,
                      value: Distance.m3000,
                      onChanged: (Distance? value) {
                        _selectValueSet(value);
                      }),
                  RadioListTile<Distance>(
                    title: const Text('2 miles'),
                    groupValue: _distanceItem,
                    value: Distance.mile2,
                    onChanged: (Distance? value) {
                      _selectValueSet(value);
                    },
                  ),
                  RadioListTile<Distance>(
                      title: const Text('5km'),
                      groupValue: _distanceItem,
                      value: Distance.m5000,
                      onChanged: (Distance? value) {
                        _selectValueSet(value);
                      }),
                  RadioListTile<Distance>(
                    title: const Text('10 km'),
                    groupValue: _distanceItem,
                    value: Distance.km10,
                    onChanged: (Distance? value) {
                      _selectValueSet(value);
                    },
                  ),
                  RadioListTile<Distance>(
                    toggleable: true,
                    title: const Text('15 km'),
                    groupValue: _distanceItem,
                    value: Distance.km15,
                    onChanged: (Distance? value) {
                      _selectValueSet(value);
                    },
                  ),
                  RadioListTile<Distance>(
                    title: const Text('Half marathon'),
                    groupValue: _distanceItem,
                    value: Distance.haflmaraton,
                    onChanged: (Distance? value) {
                      _selectValueSet(value);
                    },
                  ),
                  RadioListTile<Distance>(
                    title: const Text('Marathon'),
                    groupValue: _distanceItem,
                    value: Distance.marathon,
                    onChanged: (Distance? value) {
                      _selectValueSet(value);
                    },
                  ),
                  RadioListTile<Distance>(
                    title: const Text('Other'),
                    groupValue: _distanceItem,
                    value: Distance.other,
                    onChanged: (Distance? value) {
                      setState(() {
                        _distanceItem = value;
                        context.pop();
                        _customDistanceDialogPicker(context: context);
                      });
                    },
                  ),
                ],
              )),
            ));
      },
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
                    _distanceController.text = '$km km ${meters * 100} m';
                    context.read<CalculatorCubit>().setDistance(
                        meters: (additionKMandMeters(meters, km)), unit: 'km');
                    context.pop();
                  },
                  child: const Text('Set '))
            ],
            title: const Text("Set your distance'"),
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
    return (km + (meters * 0.1)) * 1000;
  }

  String enumToTitle(Distance? enumValue) {
    switch (enumValue) {
      case Distance.m1500:
        return '1500 m';
      case Distance.mile1:
        return '1 mile';
      case Distance.m3000:
        return '3 km';
      case Distance.mile2:
        return '2 miles';
      case Distance.m5000:
        return '5 km';
      case Distance.km10:
        return '10 km';
      case Distance.km15:
        return '15 km';
      case Distance.haflmaraton:
        return 'Half-marathon';
      case Distance.marathon:
        return 'Marathon';
      case Distance.other:
        return 'Other';
      default:
        return '5km';
    }
  }

  double enumToMeters(Distance? enumValue) {
    switch (enumValue) {
      case Distance.m1500:
        return 1500;
      case Distance.mile1:
        return 1609;
      case Distance.m3000:
        return 3000;
      case Distance.mile2:
        return 3218;
      case Distance.m5000:
        return 5000;
      case Distance.km10:
        return 10000;
      case Distance.km15:
        return 15000;
      case Distance.haflmaraton:
        return 21097;
      case Distance.marathon:
        return 42195;
      default:
        return 5000;
    }
  }

  void _selectValueSet(value) {
    context.read<CalculatorCubit>().setDistance(meters: enumToMeters(value));
    setState(() {
      _distanceItem = value;
      _distanceController.text = enumToTitle(value);

      context.pop();
    });
  }
}
