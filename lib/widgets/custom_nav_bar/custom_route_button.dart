import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/assets.dart';

class CustomRouteButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 10.0,
      ),
      child: ElevatedButton(
        onPressed: () => onPressed(context),
        style: ButtonStyle(
          animationDuration: const Duration(milliseconds: 0),
          alignment: Alignment.center,
          visualDensity: VisualDensity.compact,
          tapTargetSize: MaterialTapTargetSize.padded,
          splashFactory: InkRipple.splashFactory,
          elevation: MaterialStatePropertyAll(chosen ? 8.0 : 0.0),
          backgroundColor: MaterialStatePropertyAll(
            chosen ? Colors.black : Colors.transparent,
          ),
          foregroundColor: MaterialStatePropertyAll(
            chosen ? Colors.black : Colors.transparent,
          ),
          fixedSize: MaterialStatePropertyAll(
            chosen ? const Size(120.0, BOTTOM_NAVIGATION_BAR) : const Size(25.0, BOTTOM_NAVIGATION_BAR),
          ),
          padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 8.0,
            ),
          ),
          iconColor: MaterialStatePropertyAll(
            chosen ? context.colorScheme.background : Colors.black,
          ),
          iconSize: MaterialStatePropertyAll(size),
          side: MaterialStatePropertyAll(
            BorderSide(
              style: chosen ? BorderStyle.solid : BorderStyle.none,
            ),
          ),
          shape: MaterialStatePropertyAll(
            chosen
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
              icon,
              width: size,
              height: size,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                chosen ? Colors.white : Colors.black,
                BlendMode.srcATop,
              ),
            ),
            if (chosen) ...[
              const SizedBox(
                width: 6.0,
              ),
              DefaultTextStyle.merge(
                style: context.textTheme.bodyMedium!.copyWith(fontSize: 15.0),
                child: Text(
                  route,
                  style: TextStyle(
                    color: chosen ? Colors.white : Colors.black,
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
