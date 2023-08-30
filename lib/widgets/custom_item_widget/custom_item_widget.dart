import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';

class CustomItemWidget extends StatefulWidget {
  const CustomItemWidget(
      {super.key,
      this.isDone = false,
      required this.isFixed,
      required this.name,
      required this.subtext,
      required this.firstChild,
      required this.secondChild,});

  final bool isDone;
  final bool isFixed;
  final String name;
  final String subtext;
  final Widget secondChild;
  final Widget firstChild;

  @override
  State<CustomItemWidget> createState() => _CustomItemWidgetState();
}

class _CustomItemWidgetState extends State<CustomItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // border black, size 1, round corner 12
        border: Border.all(
          color: BLACK,
          width: BORDER_WIDTH,
        ),
        borderRadius: BorderRadius.circular(MEDIUM_CORNER),
        // fill color
        color: widget.isDone ? GREEN : WHITE,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * RATIO_PADDING),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.firstChild,
              SizedBox(width: MediaQuery.of(context).size.width * RATIO_SPACE),
              Text(
                widget.name,
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.secondChild,
              SizedBox(width: MediaQuery.of(context).size.width * RATIO_SPACE),
              Text(
                widget.subtext,
                style: context.textTheme.bodyMedium,
              ),
            ],
          )
        ],
      ),
    );
  }
}
