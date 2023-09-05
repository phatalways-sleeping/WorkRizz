import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'dart:math' as math;
import 'schedule_dbms.dart';

class RemainTasksList extends StatefulWidget {
  @override
  _RemainTasksListState createState() => _RemainTasksListState();
}

class _RemainTasksListState extends State<RemainTasksList> {
  @override
  double width = 0.0;
  double height = 0.0;
  ScrollController? scrollController;
  TextEditingController controller = TextEditingController();
  
  var schedule = ScheduleData();
  List <String> taskname = [];
  List <String> taskDescription = [];
  List <Color> taskColor = [];
   @override
  void initState() {
    taskname = schedule.getTaskName();
    taskDescription = schedule.getTaskDescription();
    taskColor = schedule.getTaskColor();
    scrollController =
        ScrollController(initialScrollOffset: 0.0);
    super.initState();
  }
  @override
  Widget RemainTitle(){
    return Container(
      //alignment: Alignment.center,
      padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 5),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(  
            alignment: Alignment.topLeft,
            //padding:  EdgeInsets.only(left: screenWidth * 0.07, right: 5, top: 20, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[ 
                Text('Schedule', style: TextStyle(color: Color(0xFF000000), fontSize: 24, fontWeight: FontWeight.w600),),
                SizedBox(width: MediaQuery.of(context).size.width * 0.35),
                Ink(
                  child: Text('View all...', style: TextStyle(color: Color(0xFF000000), fontSize: 24, fontWeight: FontWeight.w600),),

                )
                
              ],
              //Text(name, style: TextStyle(color: Color(0xFF001833), fontSize: 16,),),
            )
          ),  
        ],

      ),
    );
  }

  @override
  Widget TaskDescription(int index){
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 25, 0, 0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            
          });
        },
        child: Container(
          width: 170,
          height: 50,
          padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF000000)),
              gradient: LinearGradient(
                  colors: [Color(0xFFFFFFFF),Color(0xFFFFFFFF),Color(0xFFFFFFFF),],
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                //padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                alignment: Alignment.center,
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(
                    color: taskColor[index],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    taskname[index],
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color:  Color(0xFF000000),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  taskDescription[index],
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                     color: Color(0xFF000000),
                  )
                ),
              ],
            ),
          ),
        ),
      ));
  }

  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: 150,
      padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
      child: 
        ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: taskname.length,
          itemBuilder: (BuildContext context, int index) {
            return TaskDescription(index);
          },
        ),
      );
  }
}