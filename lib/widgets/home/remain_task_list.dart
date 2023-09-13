import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/home/subtask_button.dart';
import 'schedule_dbms.dart';

class RemainTasksList extends StatefulWidget {
  const RemainTasksList({
    super.key,
  });

  @override
  State<RemainTasksList> createState() => _RemainTasksListState();
}

class _RemainTasksListState extends State<RemainTasksList> {
  var schedule = ScheduleData();
  List<String> taskname = [];
  List<String> taskDescription = [];
  List<Color> taskColor = [];

  @override
  void initState() {
    super.initState();
    taskname = schedule.getTaskName();
    taskDescription = schedule.getTaskDescription();
    taskColor = schedule.getTaskColor();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.mediaQuery.size.height * 0.15,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: taskname.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                // Handle tap on the task.
              });
            },
            child: Draggable(
              data: index,
              childWhenDragging: Container(),
              feedback: SubTaskButton(
                color: taskColor[index],
                name: taskname[index],
                description: taskDescription[index],
              ),
              child: SubTaskButton(
                color: taskColor[index],
                name: taskname[index],
                description: taskDescription[index],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: context.mediaQuery.size.width * RATIO_PADDING,
          );
        },
      ),
    );
  }
}
