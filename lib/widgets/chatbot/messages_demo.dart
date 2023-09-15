import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';

class MessagesScreen extends StatefulWidget {
  final List messages;
  const MessagesScreen({Key? key, required this.messages}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _scrollController,
      reverse: true,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: widget.messages[index]['isUserMessage']
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(
                          20,
                        ),
                        topRight: const Radius.circular(20),
                        bottomRight: Radius.circular(
                            widget.messages[index]['isUserMessage'] ? 0 : 20),
                        topLeft: Radius.circular(
                            widget.messages[index]['isUserMessage'] ? 20 : 0),
                      ),
                      color: widget.messages[index]['isUserMessage']
                          ? Colors.green
                          : Colors.green.withOpacity(0.8)),
                  constraints: BoxConstraints(
                    maxWidth: context.mediaQuery.size.width * 2 / 3,
                  ),
                  child: Text(widget.messages[index]['message'].text.text[0])),
            ],
          ),
        );
      },
      separatorBuilder: (_, i) =>
          const Padding(padding: EdgeInsets.only(top: 10)),
      itemCount: widget.messages.length,
    );
  }
}
