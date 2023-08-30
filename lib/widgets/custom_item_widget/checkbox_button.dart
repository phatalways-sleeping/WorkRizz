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

    return Checkbox(
      checkColor: WHITE,
      // change show border color always
      side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(color: BLACK, width: BORDER_WIDTH)),
      // round corner 
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(SMALL_CORNER)),
      ),
      fillColor: MaterialStateProperty.resolveWith((states) => isChecked ? BLACK : WHITE),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}