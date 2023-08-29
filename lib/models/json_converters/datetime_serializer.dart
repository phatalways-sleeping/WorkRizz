import 'package:json_annotation/json_annotation.dart';

class DateTimeSerializer implements JsonConverter<DateTime, String> {
  const DateTimeSerializer();

  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime object) {
    return object.toIso8601String();
  }
}