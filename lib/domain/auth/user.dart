import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:noteapp_ddd_pattern/domain/auth/value_objects.dart';
part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
    @required UniqueId id,
  }) = _User;
}
