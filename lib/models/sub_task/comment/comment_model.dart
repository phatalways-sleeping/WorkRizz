import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_managing_application/models/base/base.dart';
import 'package:task_managing_application/models/json_converters/json_converters.dart';

part 'comment_model.g.dart';

// This is the model for the comment
// It contains
//  + the comment
//  + the commenter id
//  + the date of the comment
//  + the boolean value of the comment solved
//  + the boolean value of the comment replied
//  + the reply id of the comment

@JsonSerializable(explicitToJson: true)
@DocumentReferenceSerializer()
@DateTimeSerializer()
class CommentModel extends Base {
  const CommentModel({
    super.reference,
    required super.id,
    required this.comment,
    required this.commenter,
    required this.date,
    required this.solved,
    required this.isReplied,
    required this.repliedToUsername,
  });
  
  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  @JsonKey(required: true)
  final String comment;
  @JsonKey(required: true)
  final String commenter;
  @JsonKey(required: true)
  final DateTime date;
  @JsonKey(defaultValue: false)
  final bool solved;
  @JsonKey(defaultValue: false)
  final bool isReplied;
  @JsonKey(required: true)
  final String repliedToUsername;

  @override
  List<Object> get props => [
        ...super.props,
        comment,
        commenter,
        date,
        solved,
        isReplied,
        repliedToUsername,
      ];

  CommentModel copyWith({
    String? id,
    DocumentReference? reference,
    String? comment,
    String? commenter,
    DateTime? date,
    bool? solved,
    bool? isReplied,
    String? repliedToUsername,
  }) {
    return CommentModel(
      reference: reference ?? this.reference,
      id: id ?? this.id,
      comment: comment ?? this.comment,
      commenter: commenter ?? this.commenter,
      date: date ?? this.date,
      solved: solved ?? this.solved,
      isReplied: isReplied ?? this.isReplied,
      repliedToUsername: repliedToUsername ?? this.repliedToUsername,
    );
  }
}
