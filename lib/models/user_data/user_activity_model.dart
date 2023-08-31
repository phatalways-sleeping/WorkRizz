import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_managing_application/models/base/base.dart';
import 'package:task_managing_application/models/json_converters/json_converters.dart';

part 'user_activity_model.g.dart';

// This is the model for the user activity
// It contains
//  + the reference to the document in the firestore
//  + the id of the document in the firestore
//  + the boolean value of the user activity
//  + the date time of the last activity of the user

@JsonSerializable(explicitToJson: true)
@DocumentReferenceSerializer()
@DateTimeSerializer()
class UserActivityModel extends Base {
  const UserActivityModel({
    required super.reference,
    required super.id,
    required this.isActive,
    required this.lastActive,
  });

  factory UserActivityModel.fromJson(Map<String, dynamic> json) =>
      _$UserActivityModelFromJson(json);
    
  Map<String, dynamic> toJson() => _$UserActivityModelToJson(this);

  @JsonKey(defaultValue: false)
  final bool isActive;
  @JsonKey(required: true)
  final DateTime lastActive;

  @override
  List<Object> get props => [
        ...super.props,
        isActive,
        lastActive,
      ];

  UserActivityModel copyWith({
    DocumentReference? reference,
    String? id,
    bool? isActive,
    DateTime? lastActive,
  }) {
    return UserActivityModel(
      reference: reference ?? this.reference,
      id: id ?? this.id,
      isActive: isActive ?? this.isActive,
      lastActive: lastActive ?? this.lastActive,
    );
  }
}
