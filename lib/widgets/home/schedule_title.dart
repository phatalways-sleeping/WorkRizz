import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:task_managing_application/assets/assets.dart';


class ScheduleTitle extends StatefulWidget {
  const ScheduleTitle({super.key});

  @override
  _ScheduleTitleState createState() => _ScheduleTitleState();
}

class _ScheduleTitleState extends State<ScheduleTitle> {
  bool lightmode = false;
  @override
  Widget build(BuildContext context) {
    var _icon = Icons.wb_sunny_outlined;
    var _icon2 = Icons.dark_mode_outlined;
    return Container(
      //alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          horizontal: context.mediaQuery.size.width * RATIO_PADDING),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Schedule',
            style: context.textTheme.titleLarge,
          ),
          FlutterSwitch(
            borderRadius: ROUND_CORNER,
            switchBorder: Border.all(
              color: BLACK,
              width: BORDER_WIDTH,
            ),
            activeColor: WHITE,
            inactiveColor: WHITE,
            activeToggleColor: GREEN,
            inactiveToggleColor: ORANGE,
            toggleBorder: Border.all(
              color: BLACK,
              width: BORDER_WIDTH,
            ),
            value: lightmode,
            inactiveIcon: Icon(_icon),
            activeIcon: Icon(_icon2),
            onToggle: (bool value) {
              setState(() {
                lightmode = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
