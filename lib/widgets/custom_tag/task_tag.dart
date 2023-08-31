import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';

class TaskTag extends StatelessWidget {
  final Color color;
  final String name;

  const TaskTag({super.key, required this.color, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: name.length < 4 ? 30 : (name.length + 1) * 6.0,
        height: 20,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(SMALL_CORNER),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(name, style: context.textTheme.labelMedium),
        ));
  }
}
