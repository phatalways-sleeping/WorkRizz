import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';
import 'package:task_managing_application/states/states.dart'
    show NavigateToTask, NavigationBloc, ReadContext;
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'package:task_managing_application/widgets/message/message_keyboard.dart';
import 'message_scroll_view.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
    super.initState();
  }

  void changeView() {
    setState(() {
      if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      hideFloatingActionButton: true,
      hideNavigationBar: true,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: context.mediaQuery.size.height * 0.10,
                child: CustomScrollView(
                  //controller: _scrollController,
                  slivers: [
                    SliverPersistentHeader(
                      floating: true,
                      pinned: true,
                      delegate: CustomHeaderBar(
                        atHomePage: false,
                        hideAvatar: true,
                        trailing: const SizedBox.shrink(),
                        upperChild: const SizedBox.shrink(),
                        bottomChild: Container(
                          margin: EdgeInsets.only(
                            top: context.mediaQuery.size.width * RATIO_PADDING,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(
                                  context.mediaQuery.size.width * RATIO_PADDING,
                                ),
                                decoration: BoxDecoration(
                                  color: ORANGE,
                                  borderRadius:
                                      BorderRadius.circular(MEDIUM_CORNER),
                                ),
                                child: SvgPicture.string(
                                  SvgAssets.chat,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                              SizedBox(
                                width: context.mediaQuery.size.width *
                                    RATIO_PADDING,
                              ),
                              const Text(
                                "Messages",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onPressed: (context) =>
                            context.read<NavigationBloc>().add(
                                  const NavigateToTask(
                                    projectId: null,
                                    leaderId: null,
                                    projectName: null,
                                  ),
                                ),
                            
                      ),
                    ),
                  ],
                ),
              ),
              const MessageScrollView(),
            ],
          ),
          const MessageKeyboardWidget(),
        ],
      ),
    );
  }
}
