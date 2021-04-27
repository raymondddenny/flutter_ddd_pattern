// use for if the app crash

import 'package:noteapp_ddd_pattern/domain/core/failures.dart';

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() {
    const explanation =
        'Encountered a ValueFailure at an unrecoverable point. Terminating...';
    return Error.safeToString('$explanation Failure was $valueFailure');
  }
}
