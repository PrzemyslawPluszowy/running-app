import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/src/domain/entities/user_entity.dart';
import 'package:new_app/src/presentation/cubits/auth/auth_cubit_cubit.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:new_app/src/core/constants/const_value.dart';
import 'package:new_app/src/presentation/cubits/setting_page/setting_cubit.dart';
import 'package:path_provider/path_provider.dart';

import '../../widgets/avatar_image.dart';
import '../../widgets/custom_text_field.dart';

enum PICKER { age, height, weight, hrmax, hrrest }

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key, required this.user});
  final UserEntity user;
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final List _ageList = List.generate(80, (index) => index + 13);
  final List _weightList = List.generate(100, (index) => index + 40);
  final List _heightList = List.generate(150, (index) => index + 120);
  final List _hrRestList = List.generate(210, (index) => index + 30);
  final List _hrRMaxList = List.generate(120, (index) => index + 100);

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _hrRestController = TextEditingController();
  final TextEditingController _hrMaxController = TextEditingController();
  int? _weight;
  int? _height;
  int? _age;
  int? _hrmax;
  int? _hrmin;
  File? _imageAvatar;

  @override
  void initState() {
    _nameController.text = widget.user.userName!;
    _ageController.text = widget.user.age.toString();
    _heightController.text = widget.user.height.toString();
    _weightController.text = widget.user.weight.toString();
    _hrRestController.text = widget.user.hrRest.toString();
    _hrMaxController.text = widget.user.hrMax.toString();

    getImageFileFromAssets().then((value) async {
      setState(() {
        _imageAvatar = value;
      });
    });
    super.initState();
  }

  Future<File> getImageFileFromAssets() async {
    var bytes = await rootBundle.load(defaultAvatarAsssetPatch);
    final tempPatch = (await getTemporaryDirectory()).path;
    File file = File('$tempPatch/avatar.png');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

    return file;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                          colorScheme: colorScheme,
                          controller: _nameController,
                          hintText: 'Change your name',
                          label: 'Name',
                          iconData: Icons.person),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(10)),
                      height: 60,
                      width: 60,
                      child: IconButton(
                          onPressed: () {
                            context.read<AuthCubit>().logout();
                          },
                          icon: const Icon(Icons.logout,
                              color: Color(0xffF2F2F2), size: 30)),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 350,
                    child: GestureDetector(
                      onTap: () => choseImagePicker(context),
                      child: _imageAvatar == null
                          ? Container(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: double.infinity,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ))
                          : Container(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: double.infinity,
                              child: AvatarImage(
                                colorScheme: colorScheme,
                                image: _imageAvatar!,
                              )),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 300,
                    child: Column(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: CustomTextField(
                                press: () {
                                  _dialogPickerBulider(
                                      typeField: PICKER.age,
                                      context: context,
                                      list: _ageList,
                                      title: 'Pick your age',
                                      controller: _ageController,
                                      startValue: 13,
                                      unit: '');
                                },
                                readOnly: true,
                                colorScheme: colorScheme,
                                controller: _ageController,
                                label: 'Age',
                                iconData: Icons.date_range),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: CustomTextField(
                                press: () {
                                  _dialogPickerBulider(
                                      typeField: PICKER.height,
                                      context: context,
                                      list: _heightList,
                                      title: 'Pick your height',
                                      controller: _heightController,
                                      startValue: 120,
                                      unit: 'cm');
                                },
                                readOnly: true,
                                colorScheme: colorScheme,
                                controller: _heightController,
                                hintText: '',
                                label: 'Height',
                                iconData: Icons.height),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: CustomTextField(
                                press: () {
                                  _dialogPickerBulider(
                                      typeField: PICKER.weight,
                                      context: context,
                                      list: _weightList,
                                      title: 'Pick your weight',
                                      controller: _weightController,
                                      startValue: 40,
                                      unit: 'kg');
                                },
                                readOnly: true,
                                colorScheme: colorScheme,
                                controller: _weightController,
                                hintText: '',
                                label: 'Weight',
                                iconData: Icons.scale),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: CustomTextField(
                                press: () {
                                  _dialogPickerBulider(
                                    typeField: PICKER.hrrest,
                                    context: context,
                                    list: _hrRestList,
                                    title: 'set HR Rest',
                                    controller: _hrRestController,
                                    startValue: 30,
                                    unit: 'bpm',
                                  );
                                },
                                readOnly: true,
                                colorScheme: colorScheme,
                                controller: _hrRestController,
                                hintText: '',
                                label: 'HR Rest',
                                iconData: Icons.monitor_heart_outlined),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: CustomTextField(
                                press: () {
                                  _dialogPickerBulider(
                                      typeField: PICKER.hrmax,
                                      context: context,
                                      list: _hrRMaxList,
                                      title: 'set HR Max',
                                      controller: _hrMaxController,
                                      startValue: 100,
                                      unit: 'bpm');
                                },
                                readOnly: true,
                                colorScheme: colorScheme,
                                controller: _hrMaxController,
                                hintText: '',
                                label: 'HR Max',
                                iconData: Icons.monitor_heart),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              OutlinedButton(
                  onPressed: () {
                    submitFieldButton();
                  },
                  child: const Text('Save new value'))
            ],
          ),
        ),
      ),
    );
  }

  void submitFieldButton() async {
    num? bmi;
    if (_weight != null && _height != null) {
      bmi = (_weight! / ((_height! / 100) * (_height! / 100))).round();
    } else if (_weight != null) {
      bmi = (_weight! /
              ((widget.user.height! / 100) * (widget.user.height! / 100)))
          .round();
    } else {
      bmi = null;
    }
    UserEntity updateUserValue = UserEntity(
      uid: widget.user.uid,
      age: _age,
      weight: _weight,
      height: _height,
      hrMax: _hrmax,
      hrRest: _hrmin,
      userName: _nameController.text,
      imagefile: _imageAvatar,
      bmi: bmi,
    );
    context.read<SettingCubit>().updateUserField(updateUserValue);
  }

  Future<void> _dialogPickerBulider(
      {required BuildContext context,
      dynamic typeField,
      required List list,
      required String title,
      required TextEditingController controller,
      required int startValue,
      required String unit}) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          actions: [
            TextButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text('Ok'))
          ],
          title: Text(title),
          content: SizedBox(
            height: 300,
            width: 300,
            child: Center(
              child: CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: false,
                  itemExtent: 50,
                  onSelectedItemChanged: (value) {
                    setState(() {
                      if (typeField == PICKER.age) {
                        _age = value + startValue;
                      }
                      if (typeField == PICKER.weight) {
                        _weight = value + startValue;
                      }
                      if (typeField == PICKER.height) {
                        _height = value + startValue;
                      }
                      if (typeField == PICKER.hrmax) {
                        _hrmax = value + startValue;
                      }
                      if (typeField == PICKER.hrrest) {
                        _hrmin = value + startValue;
                      }

                      controller.text = '${value + startValue} $unit';
                    });
                  },
                  children:
                      list.map((e) => Center(child: Text('$e'))).toList()),
            ),
          )),
    );
  }

  void choseImagePicker(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  pickImage(source: ImageSource.camera);
                  context.pop();
                },
                icon: const Icon(
                  Icons.camera_enhance,
                  size: 50,
                )),
            IconButton(
                onPressed: () {
                  pickImage(source: ImageSource.gallery);
                  context.pop();
                },
                icon: const Icon(
                  Icons.camera,
                  size: 50,
                ))
          ],
        ),
      ),
    );
  }

  Future<void> pickImage({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: source, imageQuality: 5, maxWidth: 500, maxHeight: 500);
    if (image != null) {
      setState(() {
        _imageAvatar = File(image.path);
      });
    } else {
      print('no image selected');
    }
  }
}
