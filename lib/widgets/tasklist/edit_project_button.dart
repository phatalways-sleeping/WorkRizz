import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/states.dart';

class EditProjectButton extends StatelessWidget {
  const EditProjectButton({
    super.key,
  });

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
      onPressed: () {
        if (context.read<TasklistBloc>().state
            is! TasklistSubscriptionEditable) {
          context.read<TasklistBloc>().add(
                const TasklistRequestEditProject(),
              );
        } else {
          context.read<TasklistBloc>().add(
                const TasklistCancelEditProject(),
              );
        }
      },
      child: Icon(
        context.watch<TasklistBloc>().state is! TasklistSubscriptionEditable
            ? Icons.auto_fix_normal_rounded
            : Icons.remove_circle_outline_rounded,
        color: BLACK,
        size: 24.0,
      ),
    );
  }
}
