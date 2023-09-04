import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/models/tag/tag.dart';

class TagBuilder {
  TagBuilder._();

  final Map<String, Color> table = {};

  static final TagBuilder _tagBuilder = TagBuilder._();
  static TagBuilder get instance => _tagBuilder;

  Future<Color> getColorFromTag(Tag tag) async {
    if (table.keys.contains(tag.title)) {
      return table[tag.title]!;
    }
    final sharedPref = await SharedPreferences.getInstance();
    if (sharedPref.containsKey(
      tag.title,
    )) {
      table[tag.title] = Color(sharedPref.getInt(tag.title)!);
      return table[tag.title]!;
    }
    final desiredColor =
        LightTheme.tagColors[Random().nextInt(LightTheme.tagColors.length)];
    table[tag.title] = desiredColor;
    sharedPref.setInt(
      tag.title,
      desiredColor.value,
    );
    return desiredColor;
  }

  void removeTag(Tag tag) {
    table.remove(tag.title);
  }
}
