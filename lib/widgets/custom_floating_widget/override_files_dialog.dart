import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_dialog.dart';

Future<void> showOverridePermissonDialog({
  required void Function(BuildContext) onAccept,
  required void Function(BuildContext) onDecline,
  required void Function(BuildContext) onError,
  required BuildContext context,
}) async {
  await showDialog<bool>(
    context: context,
    builder: (context) => CustomDialog(
      title:
          'There are files with the same name, do you want to override them?',
      leftText: 'No',
      rightText: 'Yes',
      leftColor: context.colorScheme.error,
      rightColor: context.colorScheme.primary,
      focusleftColor: context.colorScheme.error,
      focusrightColor: context.colorScheme.primary,
      onLeftPressed: (context) {
        Navigator.of(context).pop(false);
      },
      onRightPressed: (context) {
        Navigator.of(context).pop(true);
      },
    ),
  ).then(
    (value) {
      if (value == null || !value) {
        onDecline(context);
      } else {
        onAccept(context);
      }
    },
  ).onError((error, stackTrace) {
    onError(context);
  });
}
