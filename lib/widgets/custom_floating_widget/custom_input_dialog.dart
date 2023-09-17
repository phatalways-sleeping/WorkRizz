import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/authentication/components.dart';

class CustomInputDialog extends StatefulWidget {
  const CustomInputDialog({
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
    this.inputLabel = '',
    this.keyboardType = TextInputType.text,
  });

  final Color leftColor;
  final Color rightColor;
  final Color focusleftColor;
  final Color focusrightColor;
  final void Function(BuildContext, TextEditingController) onLeftPressed;
  final void Function(BuildContext, TextEditingController) onRightPressed;
  final Widget title;
  final Widget leftText;
  final Widget rightText;
  final String inputLabel;
  final TextInputType keyboardType;

  @override
  State<CustomInputDialog> createState() => _CustomInputDialogState();
}

class _CustomInputDialogState extends State<CustomInputDialog> {
  late final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MEDIUM_CORNER)), //this right here
      child: Container(
        constraints: BoxConstraints(
          maxHeight: context.mediaQuery.size.height * 0.5,
          maxWidth: context.mediaQuery.size.width * 0.9,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MEDIUM_CORNER),
          color: WHITE,
          border: Border.all(
            color: BLACK,
            width: BORDER_WIDTH,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.mediaQuery.size.width * RATIO_PADDING,
          vertical: context.mediaQuery.size.height * 0.01,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DefaultTextStyle.merge(
              style: context.textTheme.titleLarge?.copyWith(
                color: BLACK,
                fontWeight: FontWeight.w600,
              ),
              child: widget.title,
            ),
            SizedBox(height: context.mediaQuery.size.width * RATIO_SPACE),
            CustomInputField(
              label: widget.inputLabel,
              controller: _controller,
              keyboardType: widget.keyboardType,
            ),
            SizedBox(height: context.mediaQuery.size.width * RATIO_SPACE),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => widget.onLeftPressed(context, _controller),
                  style: ButtonStyle(
                    alignment: Alignment.center,
                     minimumSize: MaterialStatePropertyAll(
                      Size(
                        context.mediaQuery.size.width * 0.30,
                        context.mediaQuery.size.height * 0.03 + 5,
                      ),
                    ),
                    maximumSize: MaterialStatePropertyAll(
                      Size(
                        context.mediaQuery.size.width * 0.30,
                        context.mediaQuery.size.height * 0.05,
                      ),
                    ),
                    overlayColor: MaterialStatePropertyAll(
                      widget.focusleftColor,
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
                      widget.leftColor,
                    ),
                  ),
                  child: DefaultTextStyle.merge(
                    style: context.textTheme.titleSmall?.copyWith(
                      color: BLACK,
                    ),
                    child: widget.leftText,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => widget.onRightPressed(context, _controller),
                  style: ButtonStyle(
                    alignment: Alignment.center,
                     minimumSize: MaterialStatePropertyAll(
                      Size(
                        context.mediaQuery.size.width * 0.30,
                        context.mediaQuery.size.height * 0.03 + 5,
                      ),
                    ),
                    maximumSize: MaterialStatePropertyAll(
                      Size(
                        context.mediaQuery.size.width * 0.30,
                        context.mediaQuery.size.height * 0.05,
                      ),
                    ),
                    overlayColor: MaterialStatePropertyAll(
                      widget.focusrightColor,
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
                      widget.rightColor,
                    ),
                  ),
                  child: DefaultTextStyle.merge(
                    style: context.textTheme.titleSmall?.copyWith(
                      color: BLACK,
                    ),
                    child: widget.rightText,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
