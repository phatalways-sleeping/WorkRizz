import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';

// ignore: must_be_immutable
class CustomItemWidget extends StatelessWidget {
  const CustomItemWidget({
    super.key,
    this.isFixed = true,
    required this.isDone,
    required this.name,
    required this.subtext,
    required this.firstChild,
    required this.secondChild,
    required this.onPressed,
  });
  final bool isFixed;
  final bool isDone;
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
            horizontal: MediaQuery.of(context).size.width * RATIO_PADDING * 0.8,
            vertical: MediaQuery.of(context).size.height * RATIO_PADDING * 0.4,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          firstChild,
          SizedBox(width: MediaQuery.of(context).size.width * RATIO_SPACE),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.55,
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
          SizedBox(width: MediaQuery.of(context).size.width * RATIO_SPACE),
          Text(
            subtext,
            style: context.textTheme.bodyLarge?.copyWith(
              fontSize: 14.0,
            ),
          )
        ],
      ),
    );
  }
}
