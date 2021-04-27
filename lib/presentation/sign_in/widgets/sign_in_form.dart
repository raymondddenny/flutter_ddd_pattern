import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:noteapp_ddd_pattern/application/auth/sign_in_form/sign_in_form_bloc.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
            () => null,
            (either) => either.fold((failure) {
                  FlushbarHelper.createError(
                    message: failure.map(
                      cancelledByUser: (_) =>
                          'Google sign in cancelled,maybe login with email instead?',
                      serverError: (_) =>
                          'Something error on the server, please check it later',
                      emailAlreadyInUse: (_) =>
                          'Email already been used, maybe change with another email?',
                      invalidEmailAndPasswordCombination: (_) =>
                          'Either Email or Password is invalid. Please check your input again',
                    ),
                  ).show(context);
                }, (_) {
                  return null;
                }));
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: AutovalidateMode.always,
          // autovalidate: state.validate,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const Text(
                '📔',
                style: TextStyle(
                  fontSize: 80,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 48,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                ),
                autocorrect: false,
                onChanged: (val) {
                  context
                      .read<SignInFormBloc>()
                      .add(SignInFormEvent.emailChanged(val));
                },
                validator: (_) => context
                    .read<SignInFormBloc>()
                    .state
                    .emailAddress
                    .value
                    .fold(
                        (f) => f.maybeMap(
                              invalidEmail: (_) => 'Invalid Email',
                              orElse: () => null,
                            ),
                        (_) => null),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Password',
                ),
                autocorrect: false,
                obscureText: true,
                onChanged: (val) {
                  context
                      .read<SignInFormBloc>()
                      .add(SignInFormEvent.passwordChanged(val));
                },
                validator: (_) =>
                    context.read<SignInFormBloc>().state.password.value.fold(
                        (f) => f.maybeMap(
                              shortPassword: (_) => 'Short password',
                              orElse: () => null,
                            ),
                        (_) => null),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        context.read<SignInFormBloc>().add(const SignInFormEvent
                            .signInWithEmailAndPasswordPressed());
                      },
                      child: const Text("Sign In"),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        context.read<SignInFormBloc>().add(const SignInFormEvent
                            .registerWithEmailAndPasswordPressed());
                      },
                      child: const Text("Register Account"),
                    ),
                  )
                ],
              ),
              SignInButton(
                Buttons.Google,
                text: 'Sign in with Google',
                onPressed: () {
                  context
                      .read<SignInFormBloc>()
                      .add(const SignInFormEvent.signInWithGooglePressed());
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
