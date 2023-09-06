import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/config/config.dart';
import 'package:task_managing_application/assets/extensions/build_context_extensions.dart';
import 'package:task_managing_application/assets/utils/functions.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'schedule_progress.dart';
import 'date_widget.dart';
import 'schedule_title.dart';
import 'remain_task.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
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
      // margin: const EdgeInsets.only(top: 30),
      // color: Colors.white,
      // alignment: Alignment.center,
      hideFloatingActionButton: false,
      // hideNavigationBar: true,
      child: CustomScrollView(
        // turn off scroll
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: CustomHeaderBar(
              upperChild: const Text("Hello Any"),
              bottomChild: Text(
                  "Today's ${convertWeekdayToString(DateTime.now().weekday)}"),
              onPressed: (context) {},
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: const DateCapsule(),
                ),
                // SizedBox(
                //   height: context.mediaQuery.size.width * RATIO_SPACE,
                // ),
                const ScheduleTitle(),
                Container(
                  alignment: Alignment.center,
                  child: ScheduleProgress(),
                ),
                SizedBox(
                  height: context.mediaQuery.size.width * RATIO_SPACE,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          context.mediaQuery.size.width * RATIO_PADDING),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Remaining',
                        style: context.textTheme.titleLarge,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.4),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'View all...',
                          style: context.textTheme.titleSmall?.copyWith(
                            decoration: TextDecoration.underline,
                            shadows: [
                              const Shadow(color: PURPLE, offset: Offset(0, -3))
                            ],
                            color: Colors.transparent,
                            decorationColor: PURPLE,
                            decorationThickness: 1.5,
                          ),
                        ),
                      )
                    ],
                    //Text(name, style: TextStyle(color: Color(0xFF001833), fontSize: 16,),),
                  ),
                ),
              ],
            ),
          ),
          const SliverFillRemaining(child: RemainTasksList()),
        ],
      ),
    );
  }
}
