part of 'tasklist_view.dart';

// ignore: must_be_immutable
class ListSubTask extends StatefulWidget {
  const ListSubTask({super.key});

  @override
  State<ListSubTask> createState() => _ListSubTaskState();
}

class _ListSubTaskState extends State<ListSubTask> {
  PageController controller = PageController();

  var _currentPage = 0.0;
  bool _showButton = false;
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      controller.addListener(() {
        setState(() {
          _currentPage = controller.page!;
        });
      });
    });
    controller.addListener(() {
      if (controller.position.atEdge && controller.position.pixels != 0) {
        setState(() {
          _showButton = true;
        });
      } else {
        setState(() {
          _showButton = false;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SliverToBoxAdapter(
      child: Stack(children: [
        Column(
          children: [
            SizedBox(
              // height : all remaining space
              height: 400,

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
            DotsIndicator(
              dotsCount: 4,
              position: _currentPage,
              decorator: const DotsDecorator(
                color: GREY,
                activeColor: BLACK,
              ),
            )
          ],
        ),
        if (_showButton)
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              // onHorizontalDragStart: (details) {
              //   if (details.globalPosition.dx < 60) {
              //     controller.previousPage(
              //         duration: Duration(milliseconds: 300),
              //         curve: Curves.ease);
              //   }
              // },
              child: Container(
width: context.mediaQuery.size.width * RATIO_PADDING * 2,
                height: context.mediaQuery.size.height * RATIO_PADDING * 4,
                decoration: const BoxDecoration(
                  color: PINK,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(MEDIUM_CORNER),
                  ),
                ),
                child: Center(
                  child: SvgPicture.string(SvgAssets.add),
                ),
              ),
            ),
          ),
      ]),
    );
  }
}
