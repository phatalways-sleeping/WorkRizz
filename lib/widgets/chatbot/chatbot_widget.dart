import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/models/models.dart';
import 'package:task_managing_application/states/message_bloc/message_bloc.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/file_list/filelist_widget.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_box.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.message,
    required this.isSender,
  });
  final isSender;
  final message;

  @override
  Widget build(BuildContext context) {
    return Container();
    return Container(
      margin: isSender
          ? EdgeInsets.only(
              right: context.mediaQuery.size.width * RATIO_PADDING,
              top: 10,
              bottom: 10,
            )
          : EdgeInsets.only(
              left: context.mediaQuery.size.width * RATIO_PADDING,
              top: 10,
              bottom: 10,
            ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MEDIUM_CORNER),
        border: Border.all(
          color: BLACK,
          width: BORDER_WIDTH,
        ),
        color: isSender
            ? GREEN
            : WHITE,
      ),
      padding: EdgeInsets.all(
        context.mediaQuery.size.width * RATIO_PADDING,
      ),
      width: context.mediaQuery.size.width * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text(
              message,
              style: context.textTheme.titleMedium,
            ),

        ],
      ),
    );
  }
}

