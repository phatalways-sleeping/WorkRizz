import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_managing_application/assets/assets.dart';

class ReplyButton extends StatelessWidget {
  const ReplyButton({
    super.key,
    required this.name,
    required this.backgroundColor,
    required this.onPressed,
  });

  final String name;
  final Color backgroundColor;
  final void Function(BuildContext) onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            side: const BorderSide(width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        overlayColor: MaterialStatePropertyAll(
          context.colorScheme.tertiary,
        ),
        backgroundColor: MaterialStatePropertyAll(
          backgroundColor,
        ),
        fixedSize: MaterialStatePropertyAll(
          Size(
            context.mediaQuery.size.width * 0.24,
            context.mediaQuery.size.height * 0.02,
          ),
        ),
        splashFactory: InkRipple.splashFactory,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.comfortable,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.colorScheme.onSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
