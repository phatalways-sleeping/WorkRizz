import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';

class ChatbotScrollView extends StatefulWidget {
  final List messages;
  const ChatbotScrollView({Key? key, required this.messages}) : super(key: key);

  @override
  State<ChatbotScrollView> createState() => _ChatbotScrollViewState();
}

class _ChatbotScrollViewState extends State<ChatbotScrollView> {
  late ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController = ScrollController();

    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
    super.initState();
  }

  @override
  void dispose() {
    //scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
    return ListView.separated(
        controller: _scrollController,
        reverse: false,
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
              color: widget.messages[index]['isUserMessage'] ? GREEN : WHITE,
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
        separatorBuilder: (context, i) =>
            const Padding(padding: EdgeInsets.only(top: 10)),
        itemCount: widget.messages.length);
  }
}
