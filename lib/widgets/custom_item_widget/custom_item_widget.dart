import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';

class CustomItemWidget extends StatelessWidget {
  const CustomItemWidget({
    super.key,
    required this.isDone,
    required this.name,
    required this.subtext,
    required this.firstChild,
    required this.secondChild,
    required this.onPressed,
    this.hideFirstChild = false,
  });
  final bool isDone;
  final bool hideFirstChild;
  final String name;
  final String subtext;
  final Widget secondChild;
  final Widget firstChild;
  final void Function(BuildContext) onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      style: ButtonStyle(
        fixedSize: MaterialStatePropertyAll(
          Size(
            context.mediaQuery.size.width * 0.90,
            context.mediaQuery.size.height * 0.08,
          ),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MEDIUM_CORNER),
            side: const BorderSide(
              color: BLACK,
              width: 1,
            ),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => isDone ? GREEN : WHITE,
        ),
        elevation: MaterialStateProperty.resolveWith(
          (states) => states.isPressed ? 4.0 : 0.0,
        ),
        overlayColor: const MaterialStatePropertyAll(
          PALE,
        ),
        splashFactory: InkSparkle.splashFactory,
        animationDuration: const Duration(
          seconds: 2,
        ),
        tapTargetSize: MaterialTapTargetSize.padded,
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: context.mediaQuery.size.width * RATIO_PADDING * 0.8,
            vertical: context.mediaQuery.size.height * RATIO_PADDING * 0.4,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (!hideFirstChild) ...[
            firstChild,
            SizedBox(width: context.mediaQuery.size.width * RATIO_SPACE * 0.5),
          ],
          FittedBox(
            fit: BoxFit.fitWidth,
            child: SizedBox(
              width: hideFirstChild
                  ? context.mediaQuery.size.width * 0.50
                  : context.mediaQuery.size.width * 0.54,
              child: Text(
                name,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
          const Spacer(),
          secondChild,
          SizedBox(width: context.mediaQuery.size.width * RATIO_SPACE * 0.5),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: SizedBox(
              width: context.mediaQuery.size.width * 0.12,
              child: Text(
                subtext,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontSize: 14.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
