import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/config/config.dart';
import 'package:task_managing_application/assets/svgs/svg_assets.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'package:task_managing_application/widgets/thread/mini_nav.dart';
import 'thread_widget.dart';

class ThreadView extends StatelessWidget {
  const ThreadView({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return BaseScreen(
      hideFloatingActionButton: false,
      hideNavigationBar: true,
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            floating: true,
            pinned: true,
            delegate: CustomHeaderBar(
                upperChild: const Icon(Icons.arrow_back_ios_new_outlined,
                    color: BLACK, size: 20.0),
                bottomChild: Container(
                  margin: EdgeInsets.only(top: screenWidth * RATIO_PADDING),
                  child: Row(
                    children: [
                      Container(
                          padding: EdgeInsets.all(screenWidth * RATIO_PADDING),
                          decoration: BoxDecoration(
                            color: ORANGE,
                            borderRadius: BorderRadius.circular(MEDIUM_CORNER),
                          ),
                          child: SvgPicture.string(
                            SvgAssets.thread,
                            width: 24,
                          )),
                      SizedBox(width: screenWidth * RATIO_PADDING),
                      const Text("Threads"),
                    ],
                  ),
                ),
                onPressed: (context) {}),
          ),
          const SliverToBoxAdapter(
            child: Column(
              children: [
                MiniNavThread(totalNotes: 1),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Thread(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
