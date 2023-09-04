import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/config/config.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({super.key});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: light,
      trackColor: MaterialStateProperty.resolveWith((states) {
        // Track color when the switch is selected.
        if (states.contains(MaterialState.selected)) {
          return BLACK;
        }
        return WHITE;
        // Otherwise return null to set default track color
        // for remaining states such as when the switch is
        // hovered, focused, or disabled.
      }),
      trackOutlineColor: const MaterialStatePropertyAll<Color>(BLACK),
      thumbColor: MaterialStateProperty.resolveWith((states) {
        // Track color when the switch is selected.
        if (states.contains(MaterialState.selected)) {
        return WHITE;
        }
          return BLACK;
        // Otherwise return null to set default track color
        // for remaining states such as when the switch is
        // hovered, focused, or disabled.
      }),
      onChanged: (bool value) {
        // This is called when the user toggles the switch.
        setState(() {
          light = value;
        });
      },
    );
  }
}
