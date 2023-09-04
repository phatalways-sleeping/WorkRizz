import 'package:flutter/material.dart';
import 'package:task_managing_application/models/tag/tag.dart';

class TagBuilder {
  TagBuilder._();

  final Map<String, Color> table = {};


  static TagBuilder get instance => TagBuilder._();

  Color getColorFromTag(Tag tag, Color desiredColor) {
    if (table.keys.contains(tag.title)) {
      return table[tag.title]!;
    }
    table[tag.title] = desiredColor;
    return desiredColor;
  }

  void removeTag(Tag tag) {
    table.remove(tag.title);
  }
}
