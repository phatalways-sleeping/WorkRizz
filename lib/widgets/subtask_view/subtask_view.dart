import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/assets/fonts/base_font.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/custom_avatar_widget.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'package:task_managing_application/widgets/custom_item_widget/checkbox_button.dart';

part 'comment_list.dart';
part 'file_list.dart';
part 'review.dart';

class SubTaskView extends StatelessWidget {
  const SubTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: CustomHeaderBar(
                upperChild: Row(children: [
                  const Icon(Icons.arrow_back_ios_new_outlined,
                      color: BLACK, size: 16.0),
                  SizedBox(
                    width: context.mediaQuery.size.width * RATIO_PADDING,
                  ),
                  Text('Mobile Final', style: context.textTheme.labelMedium),
                ]),
                bottomChild: const Row(
                  children: [
                    CheckboxWidget(),
                    Text("Design UI"),
                  ],
                ),
                onPressed: (context) {}),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: context.mediaQuery.size.width * RATIO_PADDING + 5.0,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('By', style: context.textTheme.titleSmall),
                          SizedBox(
                              width: context.mediaQuery.size.width *
                                  RATIO_PADDING),
                          const CustomAvatarWidget(
                              imageUrl:
                                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/falcon.jpg'),
                        ],
                      ),
                      SvgPicture.string(SvgAssets.tdot)
                    ],
                  ),
                  SizedBox(
                      height: context.mediaQuery.size.width * RATIO_PADDING),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Due Date',
                              style: context.textTheme.labelMedium),
                          Container(
                              width: context.mediaQuery.size.width * 0.4,
                              margin: EdgeInsets.only(
                                  top: context.mediaQuery.size.width * 0.01),
                              decoration: BoxDecoration(
                                // border black, size 1, round corner 12
                                border: Border.all(
                                  color: BLACK,
                                  width: BORDER_WIDTH,
                                ),
                                borderRadius:
                                    BorderRadius.circular(MEDIUM_CORNER),
                              ),
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width *
                                      RATIO_PADDING),
                              child: Row(
                                children: [
                                  const Icon(Icons.date_range_rounded,
                                      color: PALE),
                                  SizedBox(
                                      width: context.mediaQuery.size.width *
                                          RATIO_PADDING),
                                  Text('12/12/2021',
                                      style: context.textTheme.titleSmall),
                                ],
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Points', style: context.textTheme.labelMedium),
                          Container(
                              width: context.mediaQuery.size.width * 0.4,
                              margin: EdgeInsets.only(
                                  top: context.mediaQuery.size.width * 0.01),
                              decoration: BoxDecoration(
                                // border black, size 1, round corner 12
                                border: Border.all(
                                  color: BLACK,
                                  width: BORDER_WIDTH,
                                ),
                                borderRadius:
                                    BorderRadius.circular(MEDIUM_CORNER),
                              ),
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width *
                                      RATIO_PADDING),
                              child: Row(
                                children: [
                                  SvgPicture.string(
                                    SvgAssets.note,
                                    colorFilter: const ColorFilter.mode(
                                        PINK, BlendMode.srcIn),
                                  ),
                                  SizedBox(
                                      width: context.mediaQuery.size.width *
                                          RATIO_PADDING),
                                  Text('10pt',
                                      style: context.textTheme.titleSmall),
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: context.mediaQuery.size.width * RATIO_SPACE),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Description', style: context.textTheme.labelMedium),
                      Container(
                        // width: max available width, finite
                        width: double.maxFinite,
                        height: context.mediaQuery.size.height * 0.1,
                        margin: EdgeInsets.only(
                            top: context.mediaQuery.size.width * 0.01),
                        decoration: BoxDecoration(
                          // border black, size 1, round corner 12
                          border: Border.all(
                            color: BLACK,
                            width: BORDER_WIDTH,
                          ),
                          borderRadius: BorderRadius.circular(MEDIUM_CORNER),
                        ),
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * RATIO_PADDING),
                        child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nisl eget nunc aliquam aliquet.',
                            style: context.textTheme.titleSmall),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: context.mediaQuery.size.width * RATIO_SPACE),
                  const File(),
                  SizedBox(
                      height: context.mediaQuery.size.width * RATIO_PADDING),
                  const Comment(),
                  const SizedBox(),
                  const Review()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
