import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:noteapp_ddd_pattern/domain/core/errors.dart';
import 'package:noteapp_ddd_pattern/domain/core/failures.dart';

// NOTE: This class store all the abstract class such as equality;
@immutable
abstract class ValueObject<T> {
  const ValueObject();
  // left value for wrong, right for right value
  Either<ValueFailure<T>, T> get value;

  bool isValid() => value.isRight();

  /// Throws [UnexpectedValueError] containing the [ValueFailure]
  T getOrCrash() {
    //id = identity - same as writing (right) => right
    return value.fold((f) => throw UnexpectedValueError(f), id);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueObject<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value(value: $value)';
}
