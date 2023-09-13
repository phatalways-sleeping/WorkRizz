import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/config/config.dart';

class ScheduleData {
  // List<Color> colors = [Color(0xFFFF6633), Color(0xFF33FFCC), Color(0xFFFF33FF),
  // Color(0xFFFFFF99), Color(0xFF00B3E6), Color(0xFFE6B333),
  // Color(0xFF3366E6), Color(0xFF999966), Color(0xFF99FF99),
  // Color(0xFFB34D4D), Color(0xFF80B300), Color(0xFF809900),
  // Color(0xFFE6B3B3), Color(0xFF6680B3), Color(0xFF66991A),
  // Color(0xFFFF99E6), Color(0xFFCCFF1A), Color(0xFFFF1A66),
  // Color(0xFFE6331A), Color(0xFF33FFCC), Color(0xFF66994D),
  // Color(0xFFB366CC), Color(0xFF4D8000), Color(0xFFB33300),];
  List<Color> colors = [
    GREEN,
    GREY,
    ORANGE,
    PURPLE,
    PINK,
    PALE,
  ];
  List<String> taskname = [];
  List<String> taskDescription = [];
  //List<int> taskBegin = [];
  //List<int> taskEnd = [];
  List<Color> taskColor = [];
  bool isMorning = false;
  ScheduleData() {
    for (int i = 0; i < 24; i++) {
      // create 24 tasks hour
      taskname.add("Free time");
      taskColor.add(WHITE);
      taskDescription.add("You have free time");
    }
    for (int i = 0; i < 3; i++) {
      taskname[i] = 'Mobile';
      taskColor[i] = colors[0];
      taskDescription[i] = 'Clean code on branch adbdsfjdalg';
    }
    for (int i = 3; i < 5; i++) {
      taskname[i] = 'Ethics';
      taskColor[i] = colors[1];
      taskDescription[i] = "Finish paper + Submit";
    }
    for (int i = 5; i < 7; i++) {
      taskname[i] = 'Cooking';
      taskColor[i] = colors[2];
      taskDescription[i] = "Learning how to cook";
    }
    for (int i = 7; i < 9; i++) {
      taskname[i] = 'Sleeping';
      taskColor[i] = colors[3];
      taskDescription[i] = "Go to Sleeping";
    }
  }
  int getRemainTasks() {
    return taskname.length;
  }

  bool isSameTask(int firstID, int secondID) {
    return taskname[firstID] == taskname[secondID] &&
        taskDescription[firstID] == taskDescription[secondID];
  }

  List<String> getTaskName() {
    List<String> returnList = [];
    if (taskname.length == 0) {
      return returnList;
    }
    returnList.add(taskname[0]);
    for (int i = 1; i < taskname.length; i++) {
      if (!isSameTask(i - 1, i)) returnList.add(taskname[i]);
    }
    return returnList;
  }

  List<String> getTaskDescription() {
    List<String> returnList = [];
    if (taskname.length == 0) {
      return returnList;
    }
    returnList.add(taskDescription[0]);
    for (int i = 1; i < taskname.length; i++) {
      if (!isSameTask(i - 1, i)) returnList.add(taskDescription[i]);
    }
    return returnList;
  }

  List<Color> getTaskColor() {
    List<Color> returnList = [];
    if (taskname.length == 0) {
      return returnList;
    }
    returnList.add(taskColor[0]);
    for (int i = 1; i < taskname.length; i++) {
      if (!isSameTask(i - 1, i)) returnList.add(taskColor[i]);
    }
    return returnList;
  }
}
