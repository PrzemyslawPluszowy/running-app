import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/src/domain/entities/user_entity.dart';
import 'package:new_app/src/presentation/cubits/auth/auth_cubit_cubit.dart';
import 'package:new_app/src/presentation/cubits/auth/auth_cubit_state.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:new_app/src/utils/constants/const.dart';
import 'package:path_provider/path_provider.dart';

import '../../widgets/avatar_image.dart';
import '../../widgets/custom_text_field.dart';

enum PICKER { age, height, weight, hrmax, hrrest }

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final List _ageList = List.generate(80, (index) => index + 13);
  final List _weightList = List.generate(100, (index) => index + 40);
  final List _heightList = List.generate(150, (index) => index + 120);
  final List _hrRestList = List.generate(210, (index) => index + 30);
  final List _hrRMaxList = List.generate(120, (index) => index + 100);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              GestureDetector(
                onTap: () => choseImagePicker(context),
                child: _imageAvatar == null
                    ? Container(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: double.infinity,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ))
                    : Container(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: double.infinity,
                        child: AvatarImage(
                          colorScheme: colorScheme,
                          image: _imageAvatar!,
                        )),
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    color: Theme.of(context).primaryColor,
                  ),
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextField(
                            colorScheme: colorScheme,
                            controller: _nameController,
                            hintText: 'Enter your name',
                            label: 'Name',
                            iconData: Icons.person),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextField(
                            colorScheme: colorScheme,
                            controller: _emailController,
                            hintText: 'Enter your email',
                            label: 'Email',
                            iconData: Icons.email),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextField(
                          colorScheme: colorScheme,
                          controller: _passwordController,
                          hintText: 'Enter yor password',
                          label: 'Password',
                          iconData: Icons.lock,
                          isPassword: true,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        width: double.infinity,
                        height: 60,
                        child: Row(
                          children: [
                            Flexible(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
                            Flexible(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
                            Flexible(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(9),
                          child: Row(
                            children: [
                              const Flexible(child: Divider()),
                              Flexible(
                                  child: Text(
                                ' Optional ',
                                style: TextStyle(color: colorScheme.onPrimary),
                              )),
                              const Flexible(child: Divider()),
                              const Flexible(child: SizedBox())
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 3,
                        ),
                        width: double.infinity,
                        height: 60,
                        child: Row(
                          children: [
                            Flexible(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
                            Flexible(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 50,
                        child: OutlinedButton.icon(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0))),
                              side: MaterialStateProperty.all(BorderSide(
                                color: colorScheme.onPrimary,
                              )),
                              foregroundColor: MaterialStatePropertyAll(
                                  colorScheme.onPrimary),
                            ),
                            onPressed: submitFieldButton,
                            icon: BlocBuilder<AuthCubit, AuthCubitState>(
                              builder: (context, state) {
                                if (state is AuthCubitLoading) {
                                  return SizedBox(
                                      height: 50,
                                      child: Center(
                                          child: CircularProgressIndicator(
                                        color: colorScheme.onPrimaryContainer,
                                      )));
                                }
                                return const Icon(Icons.send_sharp);
                              },
                            ),
                            label: const Text('Create new profile')),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => context.go('/'),
                        child: RichText(
                          text: const TextSpan(
                            text: 'You have an account?',
                            children: [
                              TextSpan(
                                  text: ' Log in ',
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                      const Spacer()
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void submitFieldButton() async {
    UserEntity newUser = UserEntity(
      age: _age,
      weight: _weight,
      height: _height,
      hrMax: _hrmax,
      hrRest: _hrmin,
      userName: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      imagefile: _imageAvatar,
    );
    context.read<AuthCubit>().registerUser(user: newUser);
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
                  useMagnifier: true,
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
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _imageAvatar = File(image.path);
      });
    } else {
      print('no image selected');
    }
  }
}
