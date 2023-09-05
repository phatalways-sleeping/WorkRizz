part of 'tasklist_view.dart';

class SubTask extends StatelessWidget {
  const SubTask({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          floating: true,
          backgroundColor: WHITE,
          collapsedHeight: context.mediaQuery.size.width * RATIO_PADDING * 1.8,
          expandedHeight: context.mediaQuery.size.width * RATIO_PADDING * 1.8,
          toolbarHeight: context.mediaQuery.size.width * RATIO_PADDING * 1.8,
          flexibleSpace: Row(
            children: [
              const TaskTag(color: GREY, name: 'xx/xx'),
              SizedBox(width: context.mediaQuery.size.width * RATIO_PADDING),
              Text('Task name', style: context.textTheme.titleSmall),
            ],
          ),
        ),
        SliverList.builder(
            // random a number from 1 to 10 for itemCount
            itemCount: Random().nextInt(10) + 1,
            itemBuilder: (BuildContext context, int index) {
              return const SubTaskInfo();
            }),
        SliverToBoxAdapter(
          child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(MEDIUM_CORNER),
                    side: const BorderSide(
                      color: BLACK,
                      width: 1,
                    ),
                  ),
                ),
                backgroundColor: const MaterialStatePropertyAll(
                  BLACK,
                ),
                elevation: MaterialStateProperty.resolveWith(
                  (states) => states.isPressed ? 4.0 : 0.0,
                ),
                overlayColor: const MaterialStatePropertyAll(
                  GREEN,
                ),
                splashFactory: InkSparkle.splashFactory,
                animationDuration: const Duration(
                  seconds: 2,
                ),
                tapTargetSize: MaterialTapTargetSize.padded,
              ),
              child: Row(children: [
                SizedBox(width: context.mediaQuery.size.width * RATIO_PADDING),
                SvgPicture.string(SvgAssets.addwhite),
                SizedBox(
                    width: context.mediaQuery.size.width *
                        (RATIO_SPACE + RATIO_SPACE)),
                Text('Add subtask',
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: WHITE,
                    )),
              ])),
        )
      ],
    );
  }
}

class SubTaskController {
  void Function(bool)? changeColor;
}

class SubTaskInfo extends StatefulWidget {
  const SubTaskInfo({
    super.key,
  });



  @override
  State<SubTaskInfo> createState() => _SubTaskInfoState();
}

class _SubTaskInfoState extends State<SubTaskInfo> {
  bool isChecked = false;
  final SubTaskController _controller = SubTaskController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: context.mediaQuery.size.width * 0.01),
      child: CustomItemWidget(
        firstChild: CheckboxWidget(
          checkState: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
              _controller.changeColor!(isChecked);
            });
          },
        ),
        controller: _controller,
        isFixed: false,
        isDone: false,
        name: 'Design UI',
        subtext: '10pt',
        secondChild: CustomAvatarWidget(
          imageUrl:
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/falcon.jpg',
          size: context.mediaQuery.size.width * (RATIO_MARGIN + 0.01),
        ),
      ),
    );
  }
}
