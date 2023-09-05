import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'dart:math' as math;

class ScheduleTitle extends StatefulWidget {
  @override
  _ScheduleTitleState createState() => _ScheduleTitleState();
}

class _ScheduleTitleState extends State<ScheduleTitle> {


  Widget build(BuildContext context) {
    var _icon = Icons.wb_sunny_outlined;
    var _icon2 = Icons.dark_mode_outlined;
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
                IconButton(
                  icon: Icon(
                      _icon,
                      color: Color(0xFF000000),
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_icon == Icons.wb_sunny_outlined) {
                          _icon = Icons.dark_mode_outlined;
                        } else {
                          _icon = Icons.wb_sunny_outlined;
                        }
                      });
                    },
                ),
                IconButton(
                  icon: Icon(
                      _icon2,
                      color: Color(0xFF000000),
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_icon == Icons.wb_sunny_outlined) {
                          _icon = Icons.dark_mode_outlined;
                        } else {
                          _icon = Icons.wb_sunny_outlined;
                        }
                      });
                    },
                ),
                
              ],
              //Text(name, style: TextStyle(color: Color(0xFF001833), fontSize: 16,),),
            )
          ),  
        ],

      ),
    );
  }
}