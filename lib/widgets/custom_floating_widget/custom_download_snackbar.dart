import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_error_icon.dart';
import 'package:task_managing_application/widgets/custom_util_components/custom_circular_progress.dart';

SnackBar customDownloadSnackBar({
  required BuildContext context,
  String? message,
  Duration? duration,
}) {
  return SnackBar(
    backgroundColor: WHITE,
    elevation: 0.0,
    duration: duration ?? const Duration(seconds: 4),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message?? "Downloading...",
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            width: 40.0,
          ),
          const CustomCircularProgressIndicator(
            color: GREEN,
          ),
        ],
      ),
    ),
  );
}

SnackBar customDownloadStateSnackBar({
  required BuildContext context,
  required bool successful,
  String? message,
}) {
  return SnackBar(
    backgroundColor: successful ? GREEN : PALE,
    elevation: 0.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(MEDIUM_CORNER),
    ),
    behavior: SnackBarBehavior.floating,
    content: DefaultTextStyle.merge(
      style: context.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: successful ? WHITE : BLACK,
        fontSize:  13.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.fitWidth,
            child: SizedBox(
              width:  context.mediaQuery.size.width * 0.7,
              child: Text(
                successful
                    ? "File downloaded successfully"
                    : message ?? "File download failed",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          if (!successful) const CustomErrorIcon(),
        ],
      ),
    ),
  );
}
