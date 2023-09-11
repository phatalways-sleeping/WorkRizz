import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';

class CheckboxWidget extends StatelessWidget {
  const CheckboxWidget({super.key, required this.onChanged, required this.checkState});
  final Function(bool?, BuildContext) onChanged;
  final bool checkState;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.mediaQuery.size.width * 0.05,
      child: Checkbox(
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
        onChanged: (value) => onChanged(value, context),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
