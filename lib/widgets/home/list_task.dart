import 'package:flutter/material.dart';
import 'package:task_managing_application/widgets/custom_item_widget/checkbox_button.dart';
import 'package:task_managing_application/widgets/custom_tag/task_tag.dart';
import 'package:task_managing_application/assets/assets.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  ScrollController? scrollController;
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 0.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      scrollDirection: Axis.vertical,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(
                    left: context.mediaQuery.size.width * RATIO_PADDING),
                child: Row(
                  children: [
                    TaskTag(color: PALE, name: "$index"),
                    SizedBox(
                        width: context.mediaQuery.size.width * RATIO_PADDING),
                    Text("Activity $index",
                        style: context.textTheme.titleSmall),
                  ],
                )),
            ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: context.mediaQuery.size.width * RATIO_PADDING,
                    right: context.mediaQuery.size.width * RATIO_PADDING,
                    top: context.mediaQuery.size.width * RATIO_PADDING,
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.all(
                            context.mediaQuery.size.width * RATIO_PADDING),
                      ),
                      backgroundColor: MaterialStateProperty.all(WHITE),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(MEDIUM_CORNER),
                        ),
                      ),
                      side: const MaterialStatePropertyAll(
                        BorderSide(color: BLACK, width: 1),
                      ),
                      alignment: Alignment.centerLeft,
                      overlayColor: const MaterialStatePropertyAll(
                        GREEN,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'task $index ',
                          style: context.textTheme.titleMedium,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width:
                                  context.mediaQuery.size.width * RATIO_SPACE,
                            ),
                            CheckboxWidget(
                              onChanged: (isDone, context) {},
                              checkState: false,
                            ),
                            SizedBox(
                              width:
                                  context.mediaQuery.size.width * RATIO_SPACE,
                            ),
                            Text(
                              "xx pt",
                              style: context.textTheme.labelMedium?.copyWith(
                                color: BLACK,
                                fontSize: 14.0,
                              ),
                            ),
                            SizedBox(
                              width: context.mediaQuery.size.width *
                                  RATIO_SPACE /
                                  2,
                            ),
                            const Icon(Icons.lens, size: 5, color: BLACK),
                            SizedBox(
                              width: context.mediaQuery.size.width *
                                  RATIO_SPACE /
                                  2,
                            ),
                            Text(
                              "xx days left",
                              style: context.textTheme.labelMedium?.copyWith(
                                color: BLACK,
                                fontSize: 14.0,
                              ),
                            ),
                            SizedBox(
                              width:
                                  context.mediaQuery.size.width * RATIO_SPACE,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: context.mediaQuery.size.width * RATIO_SPACE * 2),
          ],
        );
      },
    );
  }
}
