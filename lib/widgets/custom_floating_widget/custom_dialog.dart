import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/config/config.dart';
import 'package:task_managing_application/assets/extensions/build_context_extensions.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.title,
    required this.leftText,
    required this.rightText,
    required this.leftColor,
    required this.rightColor,
    required this.focusleftColor,
    required this.focusrightColor,
    required this.onLeftPressed,
    required this.onRightPressed,
    this.body = const SizedBox.shrink(),
  });
  final String title;
  final String leftText;
  final String rightText;
  final Color leftColor;
  final Color rightColor;
  final Color focusleftColor;
  final Color focusrightColor;
  final void Function(BuildContext) onLeftPressed;
  final void Function(BuildContext) onRightPressed;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MEDIUM_CORNER)), //this right here
      child: Container(
        constraints: BoxConstraints(
          maxWidth: context.mediaQuery.size.width * 0.9,
          minHeight: context.mediaQuery.size.height * 0.2,
          maxHeight: context.mediaQuery.size.height * 0.4,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MEDIUM_CORNER),
          color: WHITE,
          border: Border.all(
            color: BLACK,
            width: BORDER_WIDTH,
          ),
        ),
        padding: EdgeInsets.all(context.mediaQuery.size.width * RATIO_PADDING),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: context.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: context.mediaQuery.size.width * RATIO_SPACE,
            ),
            if (body != const SizedBox.shrink()) ...[
              body,
              SizedBox(height: context.mediaQuery.size.width * RATIO_SPACE),
            ],
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    onLeftPressed(context);
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStatePropertyAll(
                      focusleftColor,
                    ),
                    fixedSize: MaterialStatePropertyAll(
                      Size(
                        context.mediaQuery.size.width * 0.3,
                        context.mediaQuery.size.height * 0.03,
                      ),
                    ),
                    splashFactory: InkSparkle.splashFactory,
                    animationDuration: const Duration(
                      seconds: 2,
                    ),
                    tapTargetSize: MaterialTapTargetSize.padded,
                    shape: const MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(MEDIUM_CORNER),
                        ),
                        // no right borderd
                        side: BorderSide.none,
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                      leftColor,
                    ),
                  ),
                  child: Text(
                    leftText,
                    style: context.textTheme.titleMedium,
                  ),
                ),
                SizedBox(width: context.mediaQuery.size.width * RATIO_SPACE),
                ElevatedButton(
                  onPressed: () {
                    onRightPressed(context);
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStatePropertyAll(
                      focusrightColor,
                    ),
                    fixedSize: MaterialStatePropertyAll(
                      Size(
                        context.mediaQuery.size.width * 0.3,
                        context.mediaQuery.size.height * 0.03,
                      ),
                    ),
                    splashFactory: InkSparkle.splashFactory,
                    animationDuration: const Duration(
                      seconds: 2,
                    ),
                    tapTargetSize: MaterialTapTargetSize.padded,
                    shape: const MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(MEDIUM_CORNER),
                        ),
                        // no right borderd
                        side: BorderSide.none,
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                      rightColor,
                    ),
                  ),
                  child: Text(
                    rightText,
                    style: context.textTheme.titleMedium,
                  ),
                ),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
