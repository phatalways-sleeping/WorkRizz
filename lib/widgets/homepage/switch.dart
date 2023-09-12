import 'package:flutter/material.dart';
import 'package:mydemo/assets/config/config.dart';
import 'package:mydemo/states/states.dart';
import 'package:mydemo/states/tasklist_bloc/tasklist_bloc.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasklistBloc, TasklistState>(
      builder: (context, state) {
        return Switch(
          // This bool value toggles the switch.
          value: (state is TasklistSubscription)
              ? state.project!.isCompleted
              : false,
          trackColor: MaterialStateProperty.resolveWith(
            (states) {
              // Track color when the switch is selected.
              if (states.contains(MaterialState.selected)) {
                return BLACK;
              }
              return WHITE;
              // Otherwise return null to set default track color
              // for remaining states such as when the switch is
              // hovered, focused, or disabled.
            },
          ),
          trackOutlineColor: const MaterialStatePropertyAll<Color>(BLACK),
          thumbColor: MaterialStateProperty.resolveWith(
            (states) {
              // Track color when the switch is selected.
              if (states.contains(MaterialState.selected)) {
                return WHITE;
              }
              return BLACK;
              // Otherwise return null to set default track color
              // for remaining states such as when the switch is
              // hovered, focused, or disabled.
            },
          ),
          onChanged: (bool value) {
            // This is called when the user toggles the switch.
            if (value) {
              context
                  .read<TasklistBloc>()
                  .add(const TasklistMarkProjectAsCompleted());
            } else {
              context
                  .read<TasklistBloc>()
                  .add(const TasklistMarkProjectAsUncompleted());
            }
          },
        );
      },
    );
  }
}
