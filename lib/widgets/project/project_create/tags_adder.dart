import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/models/models.dart';

import 'project_tag.dart';

class TagsAdder extends StatelessWidget {
  const TagsAdder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        DefaultTextStyle.merge(
          style: context.textTheme.bodySmall,
          child: Text(
            'Tag',
            style: TextStyle(
              color: context.colorScheme.onSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          height: context.mediaQuery.size.height * RATIO_PADDING * 0.3,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ProjectTagWidget(tag: Tag(title: "Paper")),
            const SizedBox(width: 10),
            const ProjectTagWidget(tag: Tag(title: "Paper")),
            SizedBox(
              width: context.mediaQuery.size.width * RATIO_PADDING * 0.8,
            ),
            Container(
              width: 20.0,
              height: 20.0,
              decoration: ShapeDecoration(
                color: context.colorScheme.onPrimary,
                shape: const OvalBorder(
                  side: BorderSide(
                    width: 1.50,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.add,
                color: Colors.black,
                size: 18.0,
              ),
            )
          ],
        ),
      ],
    );
  }
}
