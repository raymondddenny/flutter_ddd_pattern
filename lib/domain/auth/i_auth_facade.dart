import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:noteapp_ddd_pattern/domain/auth/auth_failure.dart';
import 'package:noteapp_ddd_pattern/domain/auth/value_objects.dart';

// NOTE : this class will combine all the auth method, such as firebase auth, google sign, etc
/* 
Unit its like return void, but instead return void which not a type, we return Unit, this can be replace with other type if we know
the return type the method will give.
*/

abstract class IAuthFacade {
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {@required EmailAddress emailAddress, @required Password password});
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {@required EmailAddress emailAddress, @required Password password});
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
}
