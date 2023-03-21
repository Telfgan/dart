import 'package:freezed_annotation/freezed_annotation.dart';
import 'category.dart';
part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post(
      {required int? id,
      required String? name,
      required String? content,
      required DateTime creationDate,
      required DateTime lastUpdating,
      required bool status,
      required Category category}) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
