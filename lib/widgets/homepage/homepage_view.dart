import 'package:flutter/material.dart';
import 'schedule_progress.dart';
import 'date_widget.dart';
import 'schedule_dbms.dart';
import 'schedule_title.dart';
import 'remain_task.dart';
class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late final ScrollController _scrollController = ScrollController()
    ..addListener(() {});

  get separatorBuilder => null;

  get amount => null;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child:  SingleChildScrollView(
      scrollDirection: Axis.vertical,
        child: Column(
        //alignment: Alignment.center,
        //color: Color(0xFF2D2F41),
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          
        children: <Widget>[
           Container(
            alignment: Alignment.center,
            child: DateCapsule(),
          ),
          SizedBox(height: 20,), 
          ScheduleTitle(),
          Container(
            alignment: Alignment.center,
            child: ScheduleProgress(),
          ),
          SizedBox(height: 0,),
          Container(
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
                      Text('Remaining', style: TextStyle(color: Color(0xFF000000), fontSize: 20, fontWeight: FontWeight.w600),),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.4),
                      Ink(
                        child: Text('View all...', style: TextStyle(color: Color(0xFF000000), fontSize: 20, fontWeight: FontWeight.w600),),

                      )
                      
                    ],
                    //Text(name, style: TextStyle(color: Color(0xFF001833), fontSize: 16,),),
                  )
                ),  
              ],

            ),
          ),
          Container(
            alignment: Alignment.center,
            child: RemainTasksList(),
          ),
          
        ],
      ),
     ), 
    );
  }
}