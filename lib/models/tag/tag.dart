import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Tag extends Equatable {
  const Tag({
    required this.title,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);

  @JsonKey(required: true)
  final String title;

  @override
  List<Object?> get props => [
        title,
      ];
}
