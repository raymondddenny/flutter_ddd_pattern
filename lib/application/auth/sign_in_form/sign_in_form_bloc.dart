import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:noteapp_ddd_pattern/domain/auth/auth_failure.dart';
import 'package:noteapp_ddd_pattern/domain/auth/i_auth_facade.dart';
import 'package:noteapp_ddd_pattern/domain/auth/value_objects.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';
part 'sign_in_form_bloc.freezed.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  // init auth facade
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade) : super(SignInFormState.initial());

  @override
  Stream<SignInFormState> mapEventToState(
    SignInFormEvent event,
  ) async* {
    yield* event.map(
      emailChanged: (e) async* {
        yield state.copyWith.call(
          emailAddress: EmailAddress(e.emailStr),
          authFailureOrSuccessOption: none(),
        );
      },
      passwordChanged: (e) async* {
        yield state.copyWith.call(
          password: Password(e.passwordStr),
          authFailureOrSuccessOption: none(),
        );
      },
      registerWithEmailAndPasswordPressed: (e) async* {
        yield* _performActionOnAuthFacadeWithEmailAndPassword(
          _authFacade.registerWithEmailAndPassword,
        );
      },
      signInWithEmailAndPasswordPressed: (e) async* {
        yield* _performActionOnAuthFacadeWithEmailAndPassword(
            _authFacade.signInWithEmailAndPassword);
      },
      signInWithGooglePressed: (e) async* {
        // perform the logic here
        yield state.copyWith.call(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        );

        final failureOrSuccess = await _authFacade.signInWithGoogle();

        yield state.copyWith.call(
          isSubmitting: false,
          authFailureOrSuccessOption: some(failureOrSuccess),
        );
      },
    );
  }

  Stream<SignInFormState> _performActionOnAuthFacadeWithEmailAndPassword(
      Future<Either<AuthFailure, Unit>> Function({
    @required EmailAddress emailAddress,
    @required Password password,
  })
          passingCall) async* {
    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();
    Either<AuthFailure, Unit> failureOrSuccess;
    if (isEmailValid && isPasswordValid) {
      yield state.copyWith.call(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      );

      failureOrSuccess = await passingCall(
          emailAddress: state.emailAddress, password: state.password);
    }

    yield state.copyWith.call(
      isSubmitting: false,
      validate: true,

      // authFailureOrSuccessOption: failureOrSuccess == null ?none():some(failureOrSuccess),
      authFailureOrSuccessOption: optionOf(
          failureOrSuccess), // this optionOf are run the same logic as above
    );
  }
}
