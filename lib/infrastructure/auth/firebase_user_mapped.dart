import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:noteapp_ddd_pattern/domain/auth/user.dart';
import 'package:noteapp_ddd_pattern/domain/auth/value_objects.dart';

extension FirebaseUserDomainX on firebase.User {
  User toDomain() {
    return User(id: UniqueId.fromUniqueString(uid));
  }
}
