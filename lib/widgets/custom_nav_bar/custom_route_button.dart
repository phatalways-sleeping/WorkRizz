import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/assets.dart';

class CustomRouteButton extends StatefulWidget {
  const CustomRouteButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.route,
    required this.chosen,
    this.size = 25.0,
  });

  final double size;
  final String icon;
  final String route;
  final bool chosen;
  final void Function(BuildContext context) onPressed;

  @override
  State<CustomRouteButton> createState() => _CustomRouteButtonState();
}

class _CustomRouteButtonState extends State<CustomRouteButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(right: context.mediaQuery.size.width * RATIO_PADDING),
      child: ElevatedButton(
        onPressed: () => widget.onPressed(context),
        style: ButtonStyle(
          animationDuration: const Duration(milliseconds: 0),
          alignment: Alignment.center,
          visualDensity: VisualDensity.compact,
          tapTargetSize: MaterialTapTargetSize.padded,
          splashFactory: InkRipple.splashFactory,
          elevation: MaterialStatePropertyAll(widget.chosen ? 8.0 : 0.0),
          backgroundColor: MaterialStatePropertyAll(
            widget.chosen ? Colors.black : Colors.transparent,
          ),
          foregroundColor: MaterialStatePropertyAll(
            widget.chosen ? Colors.black : Colors.transparent,
          ),
          fixedSize: MaterialStatePropertyAll(
            widget.chosen
                ? const Size(120.0, BOTTOM_NAVIGATION_BAR)
                : const Size(25.0, BOTTOM_NAVIGATION_BAR),
          ),
          padding: MaterialStatePropertyAll(
            EdgeInsets.symmetric(
              vertical: context.mediaQuery.size.height * RATIO_PADDING * 0.5,
              horizontal: context.mediaQuery.size.width * RATIO_PADDING * 0.4,
            ),
          ),
          iconColor: MaterialStatePropertyAll(
            widget.chosen ? context.colorScheme.background : Colors.black,
          ),
          iconSize: MaterialStatePropertyAll(widget.size),
          side: MaterialStatePropertyAll(
            BorderSide(
              style: widget.chosen ? BorderStyle.solid : BorderStyle.none,
            ),
          ),
          shape: MaterialStatePropertyAll(
            widget.chosen
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  )
                : const RoundedRectangleBorder(),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.string(
              widget.icon,
              width: widget.size,
              height: widget.size,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                widget.chosen ? Colors.white : Colors.black,
                BlendMode.srcATop,
              ),
            ),
            if (widget.chosen) ...[
              const SizedBox(
                width: 6.0,
              ),
              DefaultTextStyle.merge(
                style: context.textTheme.bodyMedium!.copyWith(fontSize: 15.0),
                child: Text(
                  widget.route,
                  style: TextStyle(
                    color: widget.chosen ? Colors.white : Colors.black,
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
