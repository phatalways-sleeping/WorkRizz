import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/custom_tag/project_tag.dart';
import 'schedule_dbms.dart';

class RemainTasksList extends StatefulWidget {
  const RemainTasksList({Key? key}) : super(key: key);

  @override
  _RemainTasksListState createState() => _RemainTasksListState();
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
    return Container(
        margin: EdgeInsets.symmetric(
            vertical: context.mediaQuery.size.width * RATIO_PADDING),
        child: GestureDetector(
          onTap: () {
            setState(() {});
          },
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: context.mediaQuery.size.width * RATIO_PADDING),
            width: context.mediaQuery.size.width * 0.4,
            padding:
                EdgeInsets.all(context.mediaQuery.size.width * RATIO_PADDING),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF000000)),
              gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFFFFF),
                    Color(0xFFFFFFFF),
                    Color(0xFFFFFFFF),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(0.0, 1.0),
                  stops: [0.0, 0.5, 1.0],
                  tileMode: TileMode.clamp),
              borderRadius: BorderRadius.circular(MEDIUM_CORNER * 2),
              // boxShadow: const [
              //   BoxShadow(
              //     //offset: Offset(4, 4),
              //     //blurRadius: 4,
              //     //spreadRadius: 2,
              //     color: Colors.black12,
              //   )
              // ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      bottom: context.mediaQuery.size.width * RATIO_PADDING),
                  child: ProjectTag(
                    color: taskColor[index], name: taskname[index],
                    //   //padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    //   alignment: Alignment.center,
                    //   width: 80,
                    //   height: 30,
                    //   decoration: BoxDecoration(
                    //     color: taskColor[index],
                    //     borderRadius: BorderRadius.circular(20),
                    //   ),
                    //   child: Text(
                    //     taskname[index],
                    //     style: TextStyle(
                    //       fontSize: 12,
                    //       fontWeight: FontWeight.bold,
                    //       color: Color(0xFF000000),
                    //     ),
                    //   ),
                  ),
                ),
                Text(taskDescription[index],
                    style: context.textTheme.bodyMedium),
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
      },
    );
  }
}
