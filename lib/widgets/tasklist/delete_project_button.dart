import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_dialog.dart';

class DeleteProjectButton extends StatelessWidget {
  const DeleteProjectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(WHITE),
        shape: MaterialStateProperty.all<CircleBorder>(
          const CircleBorder(),
        ),
        splashFactory: NoSplash.splashFactory,
        minimumSize: const MaterialStatePropertyAll(
          Size(
            24.0,
            24.0,
          ),
        ),
        maximumSize: const MaterialStatePropertyAll(
          Size(
            24.0,
            24.0,
          ),
        ),
        iconSize: MaterialStateProperty.all(
          24.0,
        ),
        alignment: Alignment.centerRight,
        elevation: const MaterialStatePropertyAll<double>(0.0),
      ),
      onPressed: () async {
        await showDialog<bool>(
          context: context,
          builder: (context) => CustomDialog(
            title: "Remove this Project",
            leftText: "No",
            rightText: "Yes",
            leftColor: PURPLE,
            rightColor: PINK,
            focusleftColor: PALE,
            focusrightColor: GREEN,
            onLeftPressed: (context) {
              Navigator.of(context).pop(false);
            },
            onRightPressed: (context) {
              Navigator.of(context).pop(true);
            },
          ),
        ).then(
          (value) {
            if (value == null) return;
            if (value == true) {
              context.read<TasklistBloc>().add(
                    const TasklistDeleteProject(),
                  );
            }
          },
        );
      },
      child: const Icon(
        Icons.delete_outline_rounded,
        color: BLACK,
        size: 24.0,
      ),
    );
  }
}
