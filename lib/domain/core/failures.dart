import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

// Create union

@freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {
  // handle error for invalid Email
  const factory ValueFailure.invalidEmail({
    @required String failedValue,
  }) = InvalidEmail<T>;
  // handle error for short password
  const factory ValueFailure.shortPassword({
    @required String failedValue,
  }) = ShortPassword<T>;
}
