import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';

class ProjectFilterOptionButton extends StatelessWidget {
  const ProjectFilterOptionButton({
    super.key,
    required this.title,
    required this.amount,
    required this.onTap,
    required this.isSelected,
    required this.suffixBackgroundColor,
    this.height,
    this.width,
  });

  final Widget title;
  final Color suffixBackgroundColor;
  final int amount;
  final bool isSelected;
  final double? height;
  final double? width;
  final void Function(BuildContext context) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      splashColor: Colors.transparent,
      splashFactory: InkRipple.splashFactory,
      customBorder: ContinuousRectangleBorder(
        side: BorderSide(
          color: context.colorScheme.onSecondary,
          width: 2.0,
        ),
      ),
      child: Container(
        constraints: BoxConstraints.loose(
          Size(
            width ?? context.mediaQuery.size.width * 0.40,
            height ?? context.mediaQuery.size.height * 0.18,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.mediaQuery.size.width * RATIO_PADDING,
          vertical: context.mediaQuery.size.height * RATIO_PADDING * 0.35,
        ),
        margin: EdgeInsets.only(
          left: context.mediaQuery.size.width * RATIO_MARGIN * 0.6,
        ),
        decoration: ShapeDecoration(
          color: isSelected
              ? context.colorScheme.onSecondary
              : context.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(
              color: context.colorScheme.onSecondary,
              width: 1.5,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DefaultTextStyle.merge(
              style: context.textTheme.bodySmall?.copyWith(
                color: isSelected
                    ? context.colorScheme.onPrimary
                    : context.colorScheme.onSecondary,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              child: title,
            ),
            const Spacer(),
            Container(
              constraints: const BoxConstraints.tightFor(
                width: 30.0,
                height: 23.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: suffixBackgroundColor,
              ),
              alignment: Alignment.center,
              child: DefaultTextStyle.merge(
                style: context.textTheme.bodySmall,
                child: Text(
                  amount.toString(),
                  style: TextStyle(
                    color: context.colorScheme.onSecondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
