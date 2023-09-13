import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/fonts/base_font.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/custom_avatar_widget.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_dialog.dart';
import 'message_dbms.dart';
import 'package:task_managing_application/assets/assets.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  double width = 0.0;
  double height = 0.0;
  ScrollController? scrollController;
  TextEditingController controller = TextEditingController();

  var messageManagement = MessageManagement();
  List<MessageStructure> Message = [];
  List<UserStructure> User = [];
  @override
  void initState() {
    messageManagement = MessageManagement();
    User = messageManagement.getUser();
    scrollController = ScrollController(initialScrollOffset: 0.0);
    super.initState();
  }

  Widget CategoryScroll(int userIndex, BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    Color color = COLOR_WHEEL[
        Random().nextInt(COLOR_WHEEL.length)]; /*random a color in color wheel*/
    if (userIndex >= User.length) return Container();
    Message = User[userIndex].getMessages();
    return Align(
      //alignment: Alignment.topRight,
      alignment: (User[userIndex].isSender()?Alignment.topRight:Alignment.bottomLeft),
      child: Column(
        children: [
          Container(  
              margin: EdgeInsets.only(left: width * RATIO_PADDING),
              child: Row(
                children: [
                  const CustomAvatarWidget(
                    imageUrl: 'assets/images/avt.jpg',
                    size: 30,
                  ),
                  SizedBox(width: width * RATIO_PADDING * 0.4),
                  //TaskTag(color: color, name: Message[index].user),
                  Text(
                    '${User[userIndex].userName}',
                    style: context.textTheme.titleMedium,
                  ),
                ],
              )),
          // SizedBox(height: width * RATIO_SPACE),
          ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: Message.length,
            itemBuilder: (BuildContext context, int index) {
              return MessageScroll(index, context, color);
            },
          ),
          SizedBox(height: width * RATIO_SPACE * 2),
        ],
      )
    );
    
    
  }

  Widget MessageScroll(int index, BuildContext context, Color color) {
    // bool newProject = false;
    // if (index == 0 || Message[index].originProject != Message[index - 1].originProject)
    //   newProject = true;
    // else
    //   newProject = false;
    return GestureDetector(
      onTap: () {
        setState(() {
          // download
        });
      },
      child: Container(
         margin: EdgeInsets.only(
            left: width * RATIO_PADDING * 3,
            right: width * RATIO_PADDING * 3,
            top: width * RATIO_PADDING,
          ), 
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          background: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MEDIUM_CORNER), color: BLACK),
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width / 15),
                child: const Icon(Icons.delete, color: WHITE),
              ),
            ),
          ),
          confirmDismiss: (direction) {
            return showDialog(
                context: context,
                builder: (context) => CustomDialog(
                    title: "Remove this Message",
                    leftText: "No",
                    rightText: "Yes",
                    leftColor: PURPLE,
                    rightColor: PINK,
                    focusleftColor: PALE,
                    focusrightColor: GREEN,
                    onLeftPressed: (context) {
                      Navigator.of(context).pop(false);
                    },
                    onRightPressed: (context) {
                      Navigator.of(context).pop(true);
                    }));
          },
          onDismissed: (DismissDirection direction) {
            setState(() {
              Message.removeAt(index);
            });
          },
          child: Container(
            alignment: (Message[index].isSender()?Alignment.topRight:Alignment.topLeft),
            decoration: BoxDecoration(
              color: (Message[index].isSender()?GREEN:WHITE),
              borderRadius: BorderRadius.circular(MEDIUM_CORNER),
              border: Border.all(color: BLACK, width: 1),
            ),
            padding: EdgeInsets.all(width * RATIO_PADDING),
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Message[index].type == 'text')
                  Text(
                    '${Message[index].content}',
                    style: context.textTheme.titleMedium,
                  ),
                if (Message[index].type == 'file')
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.string(
                        SvgAssets.file,
                        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                      ),
                      SizedBox(
                        width: context.mediaQuery.size.width * RATIO_SPACE,
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: SizedBox(
                          width: context.mediaQuery.size.width * 0.4,
                          child: Text(
                            Message[index].content,
                            style: context.textTheme.titleSmall,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: context.mediaQuery.size.width * RATIO_SPACE,
                      ),
                      SvgPicture.string(
                        SvgAssets.upload,
                        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return ListView.builder(
      controller: scrollController,
      scrollDirection: Axis.vertical,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: User.length,
      itemBuilder: (BuildContext context, int index) {
        return CategoryScroll(index, context);
      },
    );
  }
}