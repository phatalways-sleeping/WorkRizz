import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:task_managing_application/models/base/base.dart';
import 'package:task_managing_application/models/json_converters/json_converters.dart';
import 'package:task_managing_application/models/personal_schedule/time_line/time_line_model.dart';
part 'personal_schedule_model.g.dart';

@JsonSerializable(explicitToJson: true)
@DocumentReferenceSerializer()
@DateTimeSerializer()
class PersonalScheduleModel extends Base {
  const PersonalScheduleModel({
    required super.id,
    super.reference,
    required this.date,
    required this.schedule,
  });

  factory PersonalScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$PersonalScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalScheduleModelToJson(this);

  @JsonKey(required: true)
  final DateTime date;
  @JsonKey(required: true)
  final TimelineModel schedule;

  @override
  List<Object> get props => [
        ...super.props,
        date,
        schedule,
      ];

  PersonalScheduleModel copyWith({
    String? id,
    DocumentReference? reference,
    DateTime? date,
    TimelineModel? schedule,
  }) {
    return PersonalScheduleModel(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      date: date ?? this.date,
      schedule: schedule ?? this.schedule,
    );
  }
}
