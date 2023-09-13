
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_managing_application/assets/config/config.dart';
import 'package:task_managing_application/assets/extensions/build_context_extensions.dart';
import 'package:task_managing_application/assets/svgs/svg_assets.dart';

class MiniNavMessage extends StatelessWidget {
  const MiniNavMessage({
    super.key,
    required this.totalNotes,
  });

  final int totalNotes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.mediaQuery.size.width * RATIO_PADDING),
      child: Row(
        children: [
          const Spacer(),
          Badge(
            backgroundColor: ORANGE,
            label: Text(
              totalNotes.toString(),
              style: context.textTheme.bodySmall,
            ),
            child: SvgPicture.string(
              SvgAssets.history,
            ),
          ),
          SizedBox(
            width: context.mediaQuery.size.width * RATIO_PADDING * 2,
          ),
          SvgPicture.string(
            SvgAssets.add,
          ),
          SizedBox(
            width: context.mediaQuery.size.width * RATIO_PADDING * 2,
          ),
        ],
      ),
    );
  }
}