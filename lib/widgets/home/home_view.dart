import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/utils/functions.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'package:task_managing_application/widgets/home/list_task.dart';
import 'date_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final ScrollController _scrollController = ScrollController()
    ..addListener(() {});

  get separatorBuilder => null;

  get amount => null;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      hideNavigationBar: false,
      hideFloatingActionButton: true,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: CustomHeaderBar(
              upperChild: const Text("Hello Any"),
              bottomChild: Text(
                "Today's ${convertWeekdayToString(DateTime.now().weekday)}",
              ),
              onPressed: (context) {},
            ),
          ),
          const SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                DateCapsule(),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Activity(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
