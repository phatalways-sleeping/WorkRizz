import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_line_model.g.dart';

enum TimelineStatus {
  day,
  night,
}

@JsonSerializable()
@immutable
class TimelineModel extends Equatable {
  const TimelineModel({
    this.status = TimelineStatus.day,
    this.firstHour,
    this.secondHour,
    this.thirdHour,
    this.fourthHour,
    this.fifthHour,
    this.sixthHour,
    this.seventhHour,
    this.eighthHour,
    this.ninthHour,
    this.tenthHour,
    this.eleventhHour,
    this.twelvethHour,
  });

  factory TimelineModel.fromJson(Map<String, dynamic> json) =>
      _$TimelineModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimelineModelToJson(this);

  final TimelineStatus status;
  final String? firstHour;
  final String? secondHour;
  final String? thirdHour;
  final String? fourthHour;
  final String? fifthHour;
  final String? sixthHour;
  final String? seventhHour;
  final String? eighthHour;
  final String? ninthHour;
  final String? tenthHour;
  final String? eleventhHour;
  final String? twelvethHour;

  @override
  List<Object?> get props => [
        status,
        if (firstHour != null) firstHour,
        if (secondHour != null) secondHour,
        if (thirdHour != null) thirdHour,
        if (fourthHour != null) fourthHour,
        if (fifthHour != null) fifthHour,
        if (sixthHour != null) sixthHour,
        if (seventhHour != null) seventhHour,
        if (eighthHour != null) eighthHour,
        if (ninthHour != null) ninthHour,
        if (tenthHour != null) tenthHour,
        if (eleventhHour != null) eleventhHour,
        if (twelvethHour != null) twelvethHour,
      ];

  TimelineModel copyWith({
    TimelineStatus? status,
    String? firstHour,
    String? secondHour,
    String? thirdHour,
    String? fourthHour,
    String? fifthHour,
    String? sixthHour,
    String? seventhHour,
    String? eighthHour,
    String? ninthHour,
    String? tenthHour,
    String? eleventhHour,
    String? twelvethHour,
  }) {
    return TimelineModel(
      status: status ?? this.status,
      firstHour: firstHour ?? this.firstHour,
      secondHour: secondHour ?? this.secondHour,
      thirdHour: thirdHour ?? this.thirdHour,
      fourthHour: fourthHour ?? this.fourthHour,
      fifthHour: fifthHour ?? this.fifthHour,
      sixthHour: sixthHour ?? this.sixthHour,
      seventhHour: seventhHour ?? this.seventhHour,
      eighthHour: eighthHour ?? this.eighthHour,
      ninthHour: ninthHour ?? this.ninthHour,
      tenthHour: tenthHour ?? this.tenthHour,
      eleventhHour: eleventhHour ?? this.eleventhHour,
      twelvethHour: twelvethHour ?? this.twelvethHour,
    );
  }
}
