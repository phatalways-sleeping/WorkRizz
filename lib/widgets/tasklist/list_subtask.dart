part of 'tasklist_view.dart';

// ignore: must_be_immutable
class ListSubTask extends StatefulWidget {
  const ListSubTask({
    super.key,
    required this.changeTask,
  });

  final Function(double)? changeTask;

  @override
  State<ListSubTask> createState() => _ListSubTaskState();
}

class _ListSubTaskState extends State<ListSubTask> {
  PageController controller = PageController();

  var _currentPage = 0.0;
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      controller.addListener(() {
        setState(() {
          _currentPage = controller.page!;
          widget.changeTask!(_currentPage);
        });
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                // height : all remaining space
                constraints: BoxConstraints(
                  maxHeight: context.mediaQuery.size.height * 0.45,
                ),
                child: PageView.builder(
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                context.mediaQuery.size.width * RATIO_PADDING +
                                    5.0),
                        child: const SubTask());
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: ElevatedButton(
              onPressed: () {},
              style: const ButtonStyle(
                overlayColor: MaterialStatePropertyAll(
                  PURPLE,
                ),
                splashFactory: InkSparkle.splashFactory,
                animationDuration: Duration(
                  seconds: 2,
                ),
                tapTargetSize: MaterialTapTargetSize.padded,
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(MEDIUM_CORNER),
                    ),
                    // no right borderd
                    side: BorderSide.none,
                  ),
                ),
                backgroundColor: MaterialStatePropertyAll(
                  PINK,
                ),
              ),
              child: SvgPicture.string(SvgAssets.add),
            ),
          ),
        ],
      ),
    );
  }
}
