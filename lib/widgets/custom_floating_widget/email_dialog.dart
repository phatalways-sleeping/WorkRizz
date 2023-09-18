import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/authentication/components.dart';

class EmailDialog extends StatelessWidget {
  const EmailDialog({
    super.key,
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.4),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: context.mediaQuery.size.height * 0.4,
            maxWidth: context.mediaQuery.size.width * 0.9,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2.0),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DefaultTextStyle.merge(
                style: context.textTheme.displaySmall,
                child: const Text(
                  'Add person',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomInputField(
                label: "Email",
                controller: _controller,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 7),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(_controller.text),
                  style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(
                        vertical:
                            context.mediaQuery.size.height * RATIO_MARGIN * 0.2,
                      ),
                    ),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    backgroundColor: const MaterialStatePropertyAll(
                      Colors.black,
                    ),
                    overlayColor: MaterialStatePropertyAll(
                      context.colorScheme.primary,
                    ),
                    alignment: Alignment.center,
                    minimumSize: MaterialStatePropertyAll(
                      Size(
                        context.mediaQuery.size.width * 0.9,
                        context.mediaQuery.size.height * 0.02,
                      ),
                    ),
                    maximumSize: MaterialStatePropertyAll(
                      Size(
                        context.mediaQuery.size.width * 0.9,
                        context.mediaQuery.size.height * 0.05,
                      ),
                    ),
                  ),
                  child: DefaultTextStyle.merge(
                    style: context.textTheme.bodyLarge,
                    child: const Text(
                      'Done',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
