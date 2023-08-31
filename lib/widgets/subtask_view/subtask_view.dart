import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managing_application/assets/assets.dart';

part 'comment_list.dart';
part 'file_list.dart';
part 'review.dart';

class SubTaskView extends StatelessWidget {
  const SubTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.mediaQuery.size.width * RATIO_PADDING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(),
          SizedBox(height: context.mediaQuery.size.width * RATIO_PADDING),
          Row(),
          SizedBox(height: context.mediaQuery.size.width * RATIO_PADDING),
          File(),
          SizedBox(height: context.mediaQuery.size.width * RATIO_PADDING),
          Comment(),
          SizedBox(),
          Review()
        ],
      ),
    );
  }
}
