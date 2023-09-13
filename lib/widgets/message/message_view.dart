import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'package:task_managing_application/widgets/message/mini_nav.dart';
import 'message_widget.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      hideFloatingActionButton: true,
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            floating: true,
            pinned: true,
            delegate: CustomHeaderBar(
              upperChild: const Icon(Icons.arrow_back_ios_new_outlined,
                  color: BLACK, size: 20.0),
              bottomChild: Container(
                margin: EdgeInsets.only(
                    top: context.mediaQuery.size.width * RATIO_PADDING),
                child: Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(
                            context.mediaQuery.size.width * RATIO_PADDING),
                        decoration: BoxDecoration(
                          color: ORANGE,
                          borderRadius: BorderRadius.circular(MEDIUM_CORNER),
                        ),
                        child: SvgPicture.string(
                          SvgAssets.chat,
                          width: 24,
                        )),
                    SizedBox(
                        width: context.mediaQuery.size.width * RATIO_PADDING),
                    const Text("Messages"),
                  ],
                ),
              ),
              onPressed: (context) {},
            ),
          ),
          const SliverToBoxAdapter(
            child: Column(
              children: [
                MiniNavMessage(totalNotes: 1),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Message(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
