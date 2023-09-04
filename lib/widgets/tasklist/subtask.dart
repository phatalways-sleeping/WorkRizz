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
              return Container(
                margin: EdgeInsets.symmetric(
                    vertical:
                        context.mediaQuery.size.width * 0.01),
                child: CustomItemWidget(
                  firstChild: const CheckboxWidget(),
                  isFixed: true,
                  name: 'Design UI',
                  subtext: '10pt',
                  secondChild: CustomAvatarWidget(
                    imageUrl:
                        'https://flutter.github.io/assets-for-api-docs/assets/widgets/falcon.jpg',
                    size: context.mediaQuery.size.width * (RATIO_MARGIN + 0.01),
                  ),
                ),
              );
            }),
        SliverToBoxAdapter(
          child: Container(
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
                  ])),
        )
      ],
    );
  }
}
