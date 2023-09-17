import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/models/models.dart';

class ProjectTagWidget extends StatelessWidget {
  const ProjectTagWidget({
    super.key,
    required this.tag,
  });

  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: context.mediaQuery.size.height * 0.05,
        maxWidth: context.mediaQuery.size.width * 0.5,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.mediaQuery.size.width * RATIO_PADDING,
        vertical: 2.0,
      ),
      margin: const EdgeInsets.only(
        right: 10.0,
      ),
      decoration: ShapeDecoration(
        color: context.colorScheme.error,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: context.colorScheme.onSecondary,
            width: 1.50,
          ),
          borderRadius: BorderRadius.circular(
            MEDIUM_CORNER,
          ),
        ),
      ),
      child: DefaultTextStyle.merge(
        style: context.textTheme.bodySmall,
        child: Text(
          tag.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: context.colorScheme.onSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
