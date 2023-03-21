// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Post _$$_PostFromJson(Map<String, dynamic> json) => _$_Post(
      id: json['id'] as int?,
      name: json['name'] as String?,
      content: json['content'] as String?,
      creationDate: DateTime.parse(json['creationDate'] as String),
      lastUpdating: DateTime.parse(json['lastUpdating'] as String),
      status: json['status'] as bool,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PostToJson(_$_Post instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'content': instance.content,
      'creationDate': instance.creationDate.toIso8601String(),
      'lastUpdating': instance.lastUpdating.toIso8601String(),
      'status': instance.status,
      'category': instance.category,
    };
