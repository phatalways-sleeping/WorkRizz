import 'package:flutter/material.dart';
import 'dart:async';
import 'date_utils.dart' as date_util;

class DateCapsule extends StatefulWidget {
  @override
  _DateCapsuleState createState() => _DateCapsuleState();
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

  Widget horizontalCapsuleListView() {
    print(currentDateTime.toString());
    return Container(
      width: width,
      height: 115,
      padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: currentMonthList.length,
        itemBuilder: (BuildContext context, int index) {
          return capsuleView(index);
        },
      ),
    );
  }

  @override
  Widget capsuleView(int index) {
    print(currentDateTime.toString() + '\n');
    print(index);
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 25, 0, 0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentDateTime = currentMonthList[index];
          });
        },
        child: Container(
          width: 50,
          height: 70,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: (currentMonthList[index].day != currentDateTime.day)
                      ? [
                          Colors.white.withOpacity(0.8),
                          Colors.white.withOpacity(0.7),
                          Colors.white.withOpacity(0.6)
                        ]
                      : [
                          Color(0xFF000000),
                          Color(0xFF000000),
                          Color(0xFF000000)
                        ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.0, 1.0),
                  stops: const [0.0, 0.5, 1.0],
                  tileMode: TileMode.clamp),
              borderRadius: BorderRadius.circular(40),
              boxShadow: const [
                BoxShadow(
                  //offset: Offset(4, 4),
                  //blurRadius: 4,
                  //spreadRadius: 2,
                  color: Colors.black12,
                )
              ]),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  currentMonthList[index].day.toString(),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color:
                          (currentMonthList[index].day != currentDateTime.day)
                              ? Color(0xFF465876)
                              : Colors.white),
                ),
                Text(
                  date_util.DateUtils
                      .weekdays[currentMonthList[index].weekday - 1],
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                          (currentMonthList[index].day != currentDateTime.day)
                              ? Color(0xFF465876)
                              : Colors.white),
                )
              ],
            ),
          ),
        ),
      ));
  }
  Widget horizontalMonthListView() {
    print(currentDateTime.toString());
    return Container(
      width: width,
      height: 50,
      padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 12,
        itemBuilder: (BuildContext context, int mindex) {
          return monthView(mindex);
        },
      ),
    );
  }

  @override
  Widget monthView(int mindex) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentDateTime = date_util.DateUtils.changeMonth(currentDateTime, mindex);
            currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
            currentMonthList.sort((a, b) => a.day.compareTo(b.day));
            currentMonthList = currentMonthList.toSet().toList();
            scrollController =
                ScrollController(initialScrollOffset: 70.0 * currentDateTime.day);
            
            //if (currentDateTime.day > lastDayOfMonth())
          });
        },
        child: Container(
          width: 85,
          height: 40,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: (mindex + 1 != currentDateTime.month)
                      ? [
                          Colors.white.withOpacity(0.8),
                          Colors.white.withOpacity(0.7),
                          Colors.white.withOpacity(0.6)
                        ]
                      : [
                          Color(0xFF000000),
                          Color(0xFF000000),
                          Color(0xFF000000)
                        ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.0, 1.0),
                  stops: const [0.0, 0.5, 1.0],
                  tileMode: TileMode.clamp),
              borderRadius: BorderRadius.circular(40),
              /* boxShadow: const [
                BoxShadow(
                  offset: Offset(4, 4),
                  blurRadius: 4,
                  spreadRadius: 2,
                  color: Colors.black12,
                )
              ] */
              ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  date_util.DateUtils.months[mindex],
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color:
                          (mindex + 1!= currentDateTime.month)
                              ? Color(0xFFDDDDDD)
                              : Colors.white),
                ),
               /*  Text(
                  date_util.DateUtils
                      .weekdays[currentMonthList[index].weekday - 1],
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                          (currentMonthList[index].day != currentDateTime.day)
                              ? Color(0xFF465876)
                              : Colors.white),
                ) */
              ],
            ),
          ),
        ),
      ));
  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      //width: 300,
      //height: 100,
        child: Column(
          children: <Widget>[
            horizontalMonthListView(),
            horizontalCapsuleListView(),
          ],
        ),
    );
  }
}