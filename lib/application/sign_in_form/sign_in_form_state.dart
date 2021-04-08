part of 'sign_in_form_bloc.dart';

@freezed
abstract class SignInFormState with _$SignInFormState {
  // initial state
  factory SignInFormState.initial() => SignInFormState(
      emailAddress: EmailAddress(""),
      password: Password(""),
      isSubmitting: false,
      showErrorMessages: false,
      authFailureOrSuccessOption: none());

  const factory SignInFormState({
    @required EmailAddress emailAddress,
    @required Password password,
    @required bool isSubmitting, //to handle when state is submitting something
    @required
        bool
            showErrorMessages, // to handle state when to show the error messages during authentication
    @required Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption,
  }) = _SignInFormState;
}
