import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';

class EditReportOverlay extends StatefulWidget {
  const EditReportOverlay({
    super.key,
    required this.projectId,
    required this.onEdited,
    required this.removeOverlay,
  });

  final String projectId;
  final Function() onEdited;
  final Function() removeOverlay;

  @override
  State<EditReportOverlay> createState() => _EditReportOverlayState();
}

class _EditReportOverlayState extends State<EditReportOverlay> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        constraints: BoxConstraints.loose(
          Size(
            context.mediaQuery.size.width * 0.5,
            context.mediaQuery.size.height * 0.06,
          ),
        ),
        margin: EdgeInsets.only(
          top: context.mediaQuery.size.height * RATIO_MARGIN / 4,
          right: context.mediaQuery.size.width * RATIO_PADDING + 16.0,
        ),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: CustomButton(
          name: 'Edit Tasks',
          onPressed: ()
          {
            widget.onEdited();
            widget.removeOverlay();
          },
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.name,
    required this.onPressed,
  });

  final String name;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed(),
      style: ButtonStyle(
        fixedSize: MaterialStatePropertyAll(
          Size(
            context.mediaQuery.size.width * 0.36,
            context.mediaQuery.size.height * 0.03,
          ),
        ),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 16.0,
          ),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        overlayColor: const MaterialStatePropertyAll(
          GREEN,
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.isPressed) {
              return WHITE;
            }
            return BLACK;
          },
        ),
        backgroundColor: const MaterialStatePropertyAll(
          WHITE,
        ),
        splashFactory: InkRipple.splashFactory,
        visualDensity: VisualDensity.comfortable,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        elevation: const MaterialStatePropertyAll(0.0),
        shadowColor: const MaterialStatePropertyAll(
          Colors.transparent,
        ),
        side: MaterialStateProperty.resolveWith(
          (states) {
            if (states.isPressed) {
              return const BorderSide(
                color: GREEN,
                width: 2.0,
              );
            }
            return const BorderSide(
              color: BLACK,
              width: 2.0,
            );
          },
        ),
      ),
      child: Text(
        name,
      ),
    );
  }
}
