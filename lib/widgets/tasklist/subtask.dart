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
          child: Column(
            children: [
              CustomItemWidget(
                      firstChild: CheckboxWidget(),
                      isFixed: true,
                      name: 'Design UI',
                      subtext: '10pt',
                      secondChild: Icon(
                        Icons.add,
                      )),
                      
            ],
          ),
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
