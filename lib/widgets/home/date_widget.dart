import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/config/config.dart';
import 'package:task_managing_application/assets/extensions/build_context_extensions.dart';
import 'date_utils.dart' as date_util;

class DateCapsule extends StatefulWidget {
  const DateCapsule({super.key});

  @override
  State<DateCapsule> createState() => _DateCapsuleState();
}

class _DateCapsuleState extends State<DateCapsule> {
  double width = 0.0;
  double height = 0.0;
  ScrollController? scrollController;
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();
  List<String> todos = <String>[];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController =
        ScrollController(initialScrollOffset: 50.0 * currentDateTime.day);
    super.initState();
  }

  Widget horizontalCapsuleListView(BuildContext context) {
    return SizedBox(
      height: context.mediaQuery.size.height * 0.1,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: currentMonthList.length,
        itemBuilder: (BuildContext context, int index) {
          return capsuleView(index, context);
        },
      ),
    );
  }

  Widget capsuleView(int index, BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.mediaQuery.size.width * RATIO_PADDING),
        child: GestureDetector(
          onTap: () {
            setState(() {
              currentDateTime = currentMonthList[index];
            });
          },
          child: Container(
            width: context.mediaQuery.size.width * RATIO_PADDING * 4,
            decoration: BoxDecoration(
                color: (currentMonthList[index].day != currentDateTime.day)
                    ? WHITE
                    : BLACK,
                borderRadius: BorderRadius.circular(ROUND_CORNER),
                ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    currentMonthList[index].day.toString(),
                    style: context.textTheme.titleLarge?.copyWith(
                        color:
                            (currentMonthList[index].day != currentDateTime.day)
                                ? BLACK
                                : WHITE),
                  ),
                  SizedBox(height: context.mediaQuery.size.width * 0.01,),
                  Text(
                    date_util.DateUtils
                        .weekdays[currentMonthList[index].weekday - 1],
                    style:context.textTheme.bodyMedium?.copyWith(
                        color:
                            (currentMonthList[index].day != currentDateTime.day)
                                ? BLACK
                                :WHITE),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget horizontalMonthListView(BuildContext context) {
    return Container(
      height: 50,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 12,
        itemBuilder: (BuildContext context, int mindex) {
          return monthView(mindex, context);
        },
      ),
    );
  }

  Widget monthView(int mindex, BuildContext context) {
    return Container(
        margin: EdgeInsets.all(context.mediaQuery.size.width * RATIO_PADDING),
        child: GestureDetector(
          onTap: () {
            setState(() {
              currentDateTime =
                  date_util.DateUtils.changeMonth(currentDateTime, mindex);
              currentMonthList =
                  date_util.DateUtils.daysInMonth(currentDateTime);
              currentMonthList.sort((a, b) => a.day.compareTo(b.day));
              currentMonthList = currentMonthList.toSet().toList();
              scrollController = ScrollController(
                  initialScrollOffset: 70.0 * currentDateTime.day);
            });
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  date_util.DateUtils.months[mindex],
                  style: context.textTheme.titleMedium?.copyWith(
                      color:
                          (mindex + 1 != currentDateTime.month) ? GREY : BLACK),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        horizontalMonthListView(context),
        horizontalCapsuleListView(context),
      ],
    );
  }
}
