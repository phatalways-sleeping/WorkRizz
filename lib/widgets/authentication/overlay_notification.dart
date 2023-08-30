import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';

class OverlayNotificationEntry extends StatefulWidget {
  const OverlayNotificationEntry({super.key});

  @override
  State<OverlayNotificationEntry> createState() =>
      _OverlayNotificationEntryState();
}

class _OverlayNotificationEntryState extends State<OverlayNotificationEntry> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.mediaQuery.size.width * 0.9,
      height: context.mediaQuery.size.height * 0.2,
      decoration: ShapeDecoration(
        color: context.colorScheme.background,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.50,
            color: context.colorScheme.onSecondary,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DefaultTextStyle.merge(
            style: context.textTheme.displayMedium,
            child: Text(
              'Email Sent',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.colorScheme.onSecondary,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 7),
          DefaultTextStyle.merge(
            style: context.textTheme.displaySmall,
            child: Text(
              'Check your mail ',
              style: TextStyle(
                color: context.colorScheme.onSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ButtonStyle(
                  alignment: Alignment.center,
                  fixedSize: MaterialStatePropertyAll(
                    Size(
                      context.mediaQuery.size.width * 0.4,
                      context.mediaQuery.size.height * 0.05,
                    ),
                  ),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  backgroundColor: MaterialStatePropertyAll(
                    context.colorScheme.error,
                  ),
                ),
                child: DefaultTextStyle.merge(
                  style: context.textTheme.displaySmall,
                  child: Text(
                    'Back',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: context.colorScheme.onSecondary,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
