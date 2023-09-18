import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/states.dart'
    show NavigateToHome, NavigationBloc, ReadContext;
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'chatbot_scroll_view.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:task_managing_application/widgets/authentication/components.dart';

class ChatbotView extends StatefulWidget {
  const ChatbotView({super.key});

  @override
  State<ChatbotView> createState() => _ChatbotViewState();
}

class _ChatbotViewState extends State<ChatbotView> {
  //late ScrollController _scrollController = ScrollController();
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    //_scrollController = ScrollController();
    //_scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SafeArea(
              child: SizedBox(
                height: context.mediaQuery.size.height * 0.11,
                child: CustomScrollView(
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
                                "Virtual Assistant",
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
                                  const NavigateToHome(),
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: context.mediaQuery.size.height * 0.75,
              child: Expanded(child: ChatbotScrollView(messages: messages,),),
            ),
          ],
        ),
        Align(
          // keyboard
          alignment: Alignment.bottomCenter,
          child: Container(
            height: context.mediaQuery.size.height * 0.08,
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              bottom: context.mediaQuery.viewInsets.bottom,
            ),
            padding: EdgeInsets.all(
              context.mediaQuery.size.width * RATIO_PADDING,
            ),
            decoration: const BoxDecoration(
              color: WHITE,
              border: Border(
                top: BorderSide(
                  color: BLACK,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    sendMessage('');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: BLACK,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: WHITE,
                    size: 24.0,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: CustomInputField(
                    label: "Type a message",
                    controller: _controller,
                    showLabel: false,
                    keyboardType: TextInputType.text,
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    sendMessage(_controller.text);
                    _controller.clear();
                    //_scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: BLACK,
                  ),
                  child: const Icon(
                    Icons.send,
                    color: WHITE,
                    size: 24.0,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
        //_scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}
