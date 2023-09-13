import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/config/config.dart';
import 'package:task_managing_application/assets/extensions/build_context_extensions.dart';
import 'package:task_managing_application/assets/utils/functions.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'schedule_progress.dart';
import 'date_widget.dart';
import 'schedule_title.dart';
import 'remain_task_list.dart';

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
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const DateCapsule(),
                const ScheduleTitle(),
                const ScheduleProgress(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: context.mediaQuery.size.width * RATIO_PADDING,
                      bottom:
                          context.mediaQuery.size.width * RATIO_PADDING,
                    ),
                    child: Text(
                      'Remaining',
                      style: context.textTheme.titleLarge,
                    ),
                  ),
                ),
                const RemainTasksList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
