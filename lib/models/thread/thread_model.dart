import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_managing_application/models/base/base.dart';
import 'package:task_managing_application/models/json_converters/json_converters.dart' show DocumentReferenceSerializer;

part 'thread_model.g.dart';

// This is the model for the thread
// It contains
//  + all the properties of the base model
//  + the list of the messages id of the thread
@JsonSerializable(explicitToJson: true)
@DocumentReferenceSerializer()
class ThreadModel extends Base {
  const ThreadModel({
    required super.reference,
    required super.id,
    required this.messages,
  });

  factory ThreadModel.fromJson(Map<String, dynamic> json) =>
      _$ThreadModelFromJson(json);

  Map<String, dynamic> toJson() => _$ThreadModelToJson(this);

  @JsonKey(defaultValue: [])
  final List<String> messages;

  @override
  List<Object> get props => [
    ...super.props,
    messages,
  ];

  ThreadModel copyWith({
    String? id,
    DocumentReference? reference,
    List<String>? messages,
  }) {
    return ThreadModel(
      reference: reference ?? this.reference,
      id: id ?? this.id,
      messages: messages ?? this.messages,
    );
  }
}