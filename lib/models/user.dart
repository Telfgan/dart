import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int? id,
    required String? userName,
    required String? email,
    required String? password,
    required String? accessToken,
    required String? refreshToken,
    required String? salt,
    required String? hashPassword,
    required bool? isActive,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
