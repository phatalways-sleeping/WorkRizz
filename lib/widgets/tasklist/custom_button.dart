import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_download_snackbar.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.name,
    required this.onPressed,
    required this.message,
    this.showSnackBar = true,
  });

  final String name;
  final String message;
  final bool showSnackBar;
  final Future<void> Function(BuildContext context) onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (showSnackBar) {
          context.scaffoldMessenger.showSnackBar(
            customDownloadSnackBar(
              context: context,
              message: message,
              duration: const Duration(seconds: 15),
            ),
          );
        }
        await onPressed(context);
      },
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
