import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/custom_util_components/custom_circular_progress.dart';

SnackBar customDownloadSnackBar({
  required BuildContext context,
}) {
  return SnackBar(
    backgroundColor: WHITE,
    elevation: 0.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(MEDIUM_CORNER),
      side: const BorderSide(
        color: BLACK,
        width: BORDER_WIDTH,
      ),
    ),
    behavior: SnackBarBehavior.floating,
    content: DefaultTextStyle.merge(
      style: context.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: BLACK,
        fontSize: 16.0,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Downloading...",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: 40.0,
          ),
          CustomCircularProgressIndicator(
            color: GREEN,
          ),
        ],
      ),
    ),
  );
}
