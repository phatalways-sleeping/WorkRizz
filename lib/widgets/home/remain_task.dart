import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/custom_tag/project_tag.dart';
import 'schedule_dbms.dart';

class RemainTasksList extends StatefulWidget {
  const RemainTasksList({Key? key}) : super(key: key);

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
  void dispose() {
    super.dispose();
  }

  Widget animatedElement(int index, BuildContext context) {
    return Draggable(
      data: index,
      // feedback: Container(
      //   decoration: BoxDecoration(
      //     color: taskColor[index],
      //     borderRadius: BorderRadius.circular(ROUND_CORNER),
      //   ),
      //   width: context.mediaQuery.size.width * RATIO_PADDING * 6,
      //   height: context.mediaQuery.size.width * RATIO_PADDING * 6,
      // ), // The widget when dragging
      childWhenDragging: Container(),
      feedback: TaskDescription(index, context),
      // child: SizeTransition(
      // sizeFactor: _resizeAnimation!,
      // child: SlideTransition(
      // position: _moveAnimation,
      child: TaskDescription(index, context),
    )
        // ),
        // onDragCompleted: () {}
        // Widget when being dragged
        // );
        ;
  }

  // ignore: non_constant_identifier_names
  Widget TaskDescription(int index, BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0.0),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.all(context.mediaQuery.size.width * RATIO_PADDING),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MEDIUM_CORNER * 2),
          ),
        ),
        fixedSize: MaterialStatePropertyAll(
          Size(
            context.mediaQuery.size.width * 0.40,
            context.mediaQuery.size.width * 0.40,
          ),
        ),
        side: const MaterialStatePropertyAll(
          BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
      ),
      onPressed: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ProjectTag(
            color: taskColor[index],
            name: taskname[index],
          ),
          SizedBox(
            height: context.mediaQuery.size.width * RATIO_SPACE * 0.5,
          ),
          Text(
            taskDescription[index],
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
          child: animatedElement(index, context),
        );
      }, separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: context.mediaQuery.size.width * RATIO_PADDING,
        );
      }
    );
  }
}
