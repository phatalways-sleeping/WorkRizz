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
  late final PageController controller = PageController();
  var _currentPage = 0.0;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: context.mediaQuery.size.height * 0.48,
      ),
      margin: EdgeInsets.only(
        bottom: context.mediaQuery.size.width * RATIO_MARGIN,
      ),
      child: PageView.custom(
        controller: controller,
        padEnds: true,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _currentPage = index.toDouble();
            widget.changeTask!(_currentPage);
          });
        },
        childrenDelegate: SliverChildListDelegate(
          [
            ...List.filled(
              10,
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal:
                        context.mediaQuery.size.width * RATIO_PADDING + 5.0),
                child: const SubTask(),
              ),
            ),
            SizedBox(
              height: context.mediaQuery.size.height * RATIO_MARGIN,
            ),
            ElevatedButton(
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
            SizedBox(
              height: context.mediaQuery.size.height * 0.2,
            )
          ],
        ),
      ),
    );
  }
}
