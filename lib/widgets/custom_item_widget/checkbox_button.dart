import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/config/config.dart';

class CheckboxWidget extends StatelessWidget {
  const CheckboxWidget({super.key, required this.onChanged, required this.checkState});
  final Function(bool?) onChanged;
  final bool checkState;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checkColor: WHITE,
      // change show border color always
      side: MaterialStateBorderSide.resolveWith(
          (states) => const BorderSide(color: BLACK, width: BORDER_WIDTH)),
      // round corner
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(SMALL_CORNER)),
      ),
      fillColor: MaterialStateProperty.resolveWith(
          (states) => checkState ? BLACK : WHITE),
      value: checkState,
      onChanged: onChanged,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
