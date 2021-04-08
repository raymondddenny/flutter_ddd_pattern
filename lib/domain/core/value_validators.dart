import 'package:dartz/dartz.dart';
import 'package:noteapp_ddd_pattern/domain/core/failures.dart';

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

  if (RegExp(emailRegex).hasMatch(input)) {
    // return valid
    return right(input);
  } else {
    // if not valid
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  if (input.length >= 6) {
    // return valid
    return right(input);
  } else {
    // if not valid
    return left(ValueFailure.shortPassword(failedValue: input));
  }
}
