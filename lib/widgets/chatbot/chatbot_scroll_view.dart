import 'package:flutter/material.dart';
import 'package:task_managing_application/models/thread/message/base/message_model.dart';
import 'package:task_managing_application/models/user_data/user_activity_model.dart';
import 'package:task_managing_application/states/message_bloc/message_bloc.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/custom_avatar_widget.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/future_avatar_widget.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_error_icon.dart';
import 'package:task_managing_application/widgets/chatbot/chatbot_widget.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_avatar.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_box.dart';
import 'package:badges/badges.dart' as badges;

class ChatbotScrollView extends StatefulWidget {
  final List messages;
  const ChatbotScrollView({Key? key, required this.messages}) : super(key: key);

  @override
  State<ChatbotScrollView> createState() => _ChatbotScrollViewState();
}

class _ChatbotScrollViewState extends State<ChatbotScrollView> {
  //late final ScrollController scrollController;

  @override
  void initState() {
    //_scrollController = ScrollController();
    // scrollController.animateTo(scrollController.position.maxScrollExtent,
    //     duration: const Duration(milliseconds: 500), curve: Curves.bounceInOut);
    super.initState();
  }

  @override
  void dispose() {
    //scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    //_scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    //return Container();
    return ListView.separated(
        //controller: _scrollController,
        reverse: true,
        itemBuilder: (context, index) {
          return Container(
            margin: widget.messages[index]['isUserMessage']
                ? EdgeInsets.only(
                    left: context.mediaQuery.size.width * RATIO_PADDING * 6,
                    right: context.mediaQuery.size.width * RATIO_PADDING * 2,
                    top: 6,
                    bottom: 6,
                  )
                : EdgeInsets.only(
                    left: context.mediaQuery.size.width * RATIO_PADDING * 2,
                    right: context.mediaQuery.size.width * RATIO_PADDING * 6,
                    top: 6,
                    bottom: 6,
                  ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(MEDIUM_CORNER),
              border: Border.all(
                color: BLACK,
                width: BORDER_WIDTH,
              ),
              color: widget.messages[index]['isUserMessage']
                  ? GREEN
                  : WHITE,
            ),
            padding: EdgeInsets.all(
              context.mediaQuery.size.width * RATIO_PADDING,
            ),
            width: context.mediaQuery.size.width * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text(
                    widget.messages[index]['message'].text.text[0],
                    style: context.textTheme.titleMedium,
                  ),

              ],
            ),
          );
        },
        separatorBuilder: (_, i) => Padding(padding: EdgeInsets.only(top: 10)),
        itemCount: widget.messages.length);
  }
}
