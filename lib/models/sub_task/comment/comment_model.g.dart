// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['comment', 'commenter', 'date', 'replyCommentId'],
  );
  return CommentModel(
    reference: _$JsonConverterFromJson<DocumentReference<Object?>,
            DocumentReference<Object?>>(
        json['reference'], const DocumentReferenceSerializer().fromJson),
    id: json['id'] as String,
    comment: json['comment'] as String,
    commenter: json['commenter'] as String,
    date: const DateTimeSerializer().fromJson(json['date'] as String),
    solved: json['solved'] as bool? ?? false,
    isReplied: json['isReplied'] as bool? ?? false,
    replyCommentId: json['replyCommentId'] as String,
  );
}

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'reference': _$JsonConverterToJson<DocumentReference<Object?>,
              DocumentReference<Object?>>(
          instance.reference, const DocumentReferenceSerializer().toJson),
      'id': instance.id,
      'comment': instance.comment,
      'commenter': instance.commenter,
      'date': const DateTimeSerializer().toJson(instance.date),
      'solved': instance.solved,
      'isReplied': instance.isReplied,
      'replyCommentId': instance.replyCommentId,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
