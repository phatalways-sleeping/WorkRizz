import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';

SnackBar createErrorSnackBar({
  required BuildContext context,
  String? error,
  void Function(BuildContext)? onPressed,
}) =>
    SnackBar(
      backgroundColor: context.colorScheme.error,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MEDIUM_CORNER),
        side: const BorderSide(
          color: BLACK,
          width: BORDER_WIDTH,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Try again',
        onPressed: onPressed != null ? () => onPressed(context) : () {},
        backgroundColor: context.colorScheme.onSecondary,
        textColor: context.colorScheme.onPrimary,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: context.mediaQuery.size.width * RATIO_MARGIN * 0.7,
        vertical: context.mediaQuery.size.height * RATIO_MARGIN * 0.5,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.mediaQuery.size.width * RATIO_MARGIN * 0.7,
        vertical: 10.0,
      ),
      content: Center(
        child: Text(
          error ?? 'Something went wrong. Please try again',
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.onSecondary,
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
          ),
        ),
      ),
    );
