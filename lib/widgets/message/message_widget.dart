import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/models/models.dart';
import 'package:task_managing_application/states/message_bloc/message_bloc.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_box.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.message,
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: context.read<MessageBloc>().isSender(message.sender)
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
          width: 0.5,
        ),
        color: context.read<MessageBloc>().isSender(message.sender)
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
          if (message is TextMessageModel)
            Text(
              (message as TextMessageModel).text,
              style: context.textTheme.titleMedium,
            ),
          if (message is FileMessageModel)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SvgPicture.string(
                  SvgAssets.file,
                  colorFilter: const ColorFilter.mode(
                    GREEN,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(
                  width: context.mediaQuery.size.width * RATIO_SPACE,
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: SizedBox(
                    width: context.mediaQuery.size.width * 0.4,
                    child: Text(
                      (message as FileMessageModel).fileName,
                      style: context.textTheme.titleSmall,
                    ),
                  ),
                ),
              ],
            ),
          if (message is ImageMessageModel)
            FutureBuilder(
              future: context
                  .read<MessageBloc>()
                  .imageUrlFuture((message as ImageMessageModel).imageUrl),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(MEDIUM_CORNER),
                    child: Image.network(
                      snapshot.data as String,
                      fit: BoxFit.fitWidth,
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return ShimmerBox(
                    width: context.mediaQuery.size.width * 0.4,
                    height: context.mediaQuery.size.width * 0.4,
                  );
                }
                return const SizedBox.shrink();
              },
            )
        ],
      ),
    );
  }
}
