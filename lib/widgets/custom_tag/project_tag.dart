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
        vertical: 1.0,
      ),
      constraints: BoxConstraints.loose(
        Size(
          MediaQuery.of(context).size.width * 0.3,
          MediaQuery.of(context).size.width * RATIO_PADDING * 1.8,
        ),
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(ROUND_CORNER),
      ),
      alignment: Alignment.center,
      child: Text(
        name,
        style: context.textTheme.bodySmall?.copyWith(
          color: context.colorScheme.onSecondary,
          fontWeight: FontWeight.w500,
          fontSize: 13.0,
        ),
      ),
    );
  }
}
