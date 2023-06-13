import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../cubits/auth/auth_cubit_cubit.dart';
import '../../cubits/auth/auth_cubit_state.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Column(
        children: [
          Flexible(
            child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/run.png',
                  fit: BoxFit.fitWidth,
                )),
          ),
          Flexible(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: Theme.of(context).primaryColor,
                ),
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        colorScheme: colorScheme,
                        controller: _emailController,
                        hintText: 'Login',
                        iconData: Icons.person,
                        label: 'Input your email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        colorScheme: colorScheme,
                        controller: _passwordController,
                        hintText: 'Password',
                        iconData: Icons.lock_person,
                        label: 'Enter your password',
                      ),
                    ),
                    BlocBuilder<AuthCubit, AuthCubitState>(
                      builder: (context, state) {
                        if (state is AuthCubitForgotPass) {
                          return Center(
                            child: GestureDetector(
                              onTap: () {
                                context.read<AuthCubit>().forgotPassword(
                                    email: _emailController.text);
                              },
                              child: errText(
                                  'Forgot password?', 'Click hto reset '),
                            ),
                          );
                        }
                        if (state is AuthCubitErrForgetPass) {
                          return errText('Error', 'Check your email');
                        }
                        if (state is SendEmailSuccess) {
                          return errText('Success', 'We send you email');
                        }
                        return const SizedBox();
                      },
                    ),
                    const Spacer(),
                    Center(
                      child: SizedBox(
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
                            onPressed: logIn,
                            icon: BlocBuilder<AuthCubit, AuthCubitState>(
                              builder: (context, state) {
                                if (state is AuthCubitLoading) {
                                  return SizedBox(
                                      height: 50,
                                      child: Center(
                                          child: CircularProgressIndicator(
                                        color: colorScheme.onPrimary,
                                      )));
                                }
                                return const Icon(Icons.send_sharp);
                              },
                            ),
                            label: const Text('Log in')),
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: GestureDetector(
                        onTap: () => context.go('/register'),
                        child: RichText(
                            text: const TextSpan(
                          text: "You dont'have an account?",
                          children: [
                            TextSpan(
                                text: ' Register ',
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        )),
                      ),
                    ),
                    const Spacer()
                  ],
                )),
          ),
        ],
      ),
    );
  }

  RichText errText(String firstText, String secondText) {
    return RichText(
        text: TextSpan(
      text: firstText,
      children: [
        TextSpan(
            text: secondText, style: TextStyle(fontWeight: FontWeight.bold))
      ],
    ));
  }

  void logIn() {
    context.read<AuthCubit>().loginregisterUser(
        email: _emailController.text, password: _passwordController.text);
  }
}
