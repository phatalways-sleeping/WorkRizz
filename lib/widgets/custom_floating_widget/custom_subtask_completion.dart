import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/custom_util_components/custom_circular_progress.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
    createSubTaskCompletionSnackBar({
  required BuildContext context,
  Widget? child,
}) =>
        context.scaffoldMessenger.showSnackBar(
          SnackBar(
            backgroundColor: context.colorScheme.onPrimary,
            duration: const Duration(
              seconds: 4,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MEDIUM_CORNER),
              side: const BorderSide(
                color: BLACK,
                width: BORDER_WIDTH,
              ),
            ),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(
              horizontal: context.mediaQuery.size.width * RATIO_MARGIN * 0.7,
              vertical: context.mediaQuery.size.height * RATIO_MARGIN * 0.5,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: context.mediaQuery.size.width * RATIO_MARGIN * 0.7,
              vertical: 10.0,
            ),
            content: Container(
              constraints: BoxConstraints(
                maxWidth: context.mediaQuery.size.width * 0.9,
                maxHeight: context.mediaQuery.size.height * 0.1,
              ),
              child: Center(
                child: child ??
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Update is underway...',
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: context.colorScheme.onSecondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        const CustomCircularProgressIndicator(
                          color: GREEN,
                          size: 30.0,
                        ),
                      ],
                    ),
              ),
            ),
          ),
        );
