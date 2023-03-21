import 'package:freezed_annotation/freezed_annotation.dart';

part 'ModelNotif.freezed.dart';
part 'ModelNotif.g.dart';

@freezed
class ModelNotif with _$ModelNotif {
  const factory ModelNotif({
    required String? error,
    required dynamic data,
    required String? message,
  }) = _ModelNotif;

  factory ModelNotif.fromJson(Map<String, dynamic> json) =>
      _$ModelNotifFromJson(json);
}
