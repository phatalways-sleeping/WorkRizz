import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';

class ProjectTag extends StatelessWidget {
  final Color color;
  final String name;

  const ProjectTag({super.key, required this.color, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * RATIO_MARGIN,
          vertical: MediaQuery.of(context).size.height * 0.005,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(ROUND_CORNER),
        ),
        child: Text(name, style: context.textTheme.labelMedium));
  }
}
