import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_managing_application/models/json_converters/json_converters.dart';
import 'package:task_managing_application/models/thread/message/base/message_model.dart';

part 'image_message_model.g.dart';
// This is the model for the image message
// It contains
//  + all the properties of the message model
//  + the image url of the message in the firebase storage

@JsonSerializable(explicitToJson: true)
@DocumentReferenceSerializer()
@DateTimeSerializer()
final class ImageMessageModel extends MessageModel {
  const ImageMessageModel({
    required super.reference,
    required super.id,
    required super.sender,
    required super.time,
    required this.imageUrl,
  });

  factory ImageMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageMessageModelToJson(this);

  @JsonKey(required: true)
  final String imageUrl;

  @override
  List<Object> get props => [
        ...super.props,
        imageUrl,
      ];

  ImageMessageModel copyWith({
    DocumentReference? reference,
    String? id,
    String? sender,
    DateTime? time,
    String? imageUrl,
  }) {
    return ImageMessageModel(
      reference: reference ?? this.reference,
      id: id ?? this.id,
      sender: sender ?? this.sender,
      time: time ?? this.time,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}