import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';
// NOTE: this class is for collect all possible error during authentication

@freezed
abstract class AuthFailure with _$AuthFailure {
  const factory AuthFailure.cancelledByUser() =
      CancelledByUser; // to handle when user tabsout during google sign in
  const factory AuthFailure.serverError() =
      ServerError; // to handle when there are server error during authentication
  const factory AuthFailure.emailAlreadyInUse() =
      EmailAlreadyInUse; // to handle when email already been registered
  const factory AuthFailure.invalidEmailAndPasswordCombination() =
      InvalidEmailAndPasswordCombination; // to handle when user input wrong email and password combination
}
