part of 'tasklist_view.dart';

class SubTask extends StatelessWidget {
  const SubTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TaskTag(color: GREY, name: 'xx/xx'),
            SizedBox(width: context.mediaQuery.size.width * RATIO_PADDING),
            Text('Task name', style: context.textTheme.titleSmall),
          ],
        ),
        SizedBox(height: context.mediaQuery.size.width * RATIO_PADDING),
        SingleChildScrollView(
          child: Column(children: [
            CustomItemWidget(
              firstChild: CheckboxWidget(),
              isFixed: true,
              name: 'Design UI',
              subtext: '10pt',
              secondChild: CustomAvatarWidget(
                  imageUrl:
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/falcon.jpg',
                  size: context.mediaQuery.size.width * (RATIO_MARGIN + 0.01)),
            ),
            SizedBox(height: context.mediaQuery.size.width * RATIO_PADDING),
            Container(
                decoration: BoxDecoration(
                  // border black, size 1, round corner 12
                  border: Border.all(
                    color: BLACK,
                    width: BORDER_WIDTH,
                  ),
                  borderRadius: BorderRadius.circular(MEDIUM_CORNER),
                  // fill color
                  color: BLACK,
                ),
                padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * RATIO_PADDING),
                child: Row(children: [
                  SizedBox(
                      width: context.mediaQuery.size.width * RATIO_PADDING),
                  SvgPicture.string(SvgAssets.addwhite),
                  SizedBox(
                      width: context.mediaQuery.size.width * (RATIO_SPACE + RATIO_SPACE)),
                  Text('Add subtask',
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: WHITE,
                      )),
                ]))
          ]),
        )
        // a widget which is list scrollable of 8 CustomItemWidget
        // ListView.builder(
        //   scrollDirection: Axis.horizontal,
        //   itemCount: 8,
        //   itemBuilder: (context, index) {
        //     return CustomItemWidget(
        //         firstChild: CheckboxWidget(),
        //         isFixed: true,
        //         name: 'Design UI',
        //         subtext: '10pt',
        //         secondChild: Icon(
        //           Icons.add,
        //         ));
        //   },
        // ),
      ],
    );
  }
}
