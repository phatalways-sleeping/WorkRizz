import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/config/config.dart';

class CheckboxWidget extends StatefulWidget {
  const CheckboxWidget({super.key});

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return GREEN;
      }
      // if it is ticked change to black
      if (isChecked) {
        return BLACK;
      }
      return WHITE;
    }

    BorderSide getBorder(Set<MaterialState> states) {
      return const BorderSide(color: BLACK, width: BORDER_WIDTH);
    }

    return Checkbox(
      checkColor: WHITE,
      // change show border color always
      side: MaterialStateBorderSide.resolveWith(getBorder),
      // round corner 
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(SMALL_CORNER)),
      ),
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}