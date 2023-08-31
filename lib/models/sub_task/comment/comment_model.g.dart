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
    reference: const DocumentReferenceSerializer()
        .fromJson(json['reference'] as DocumentReference<Object?>),
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
      'reference':
          const DocumentReferenceSerializer().toJson(instance.reference),
      'id': instance.id,
      'comment': instance.comment,
      'commenter': instance.commenter,
      'date': const DateTimeSerializer().toJson(instance.date),
      'solved': instance.solved,
      'isReplied': instance.isReplied,
      'replyCommentId': instance.replyCommentId,
    };
