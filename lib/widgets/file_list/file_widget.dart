import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/custom_avatar_widget.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_dialog.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_error_icon.dart';
import 'package:task_managing_application/widgets/custom_util_components/custom_circular_progress.dart';

class FileWidget extends StatelessWidget {
  const FileWidget({
    super.key,
    required this.fileName,
    required this.ownerImageUrl,
    required this.color,
    required this.index,
    required this.date,
  });

  final String fileName;
  final String ownerImageUrl;
  final Color color;
  final int index;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(
            vertical: context.mediaQuery.size.width * RATIO_PADDING * 1.5,
            horizontal: context.mediaQuery.size.width * RATIO_PADDING * 1.8,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          WHITE,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: const BorderSide(
              color: BLACK,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(MEDIUM_CORNER),
          ),
        ),
        splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
        overlayColor: MaterialStatePropertyAll(
          color.withOpacity(0.1),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
      onPressed: () => context.read<FilelistBloc>().add(
            FilelistDownloadFileEvent(
              'files/$fileName',
            ),
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
                right: MediaQuery.of(context).size.width / 15,
              ),
              child: const Icon(Icons.delete, color: WHITE),
            ),
          ),
        ),
        confirmDismiss: (direction) {
          return showDialog<bool>(
            context: context,
            builder: (context) => CustomDialog(
              title: "Remove this File",
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
              },
            ),
          ).then(
            (value) {
              if (value != null && value) {
                context.read<FilelistBloc>().add(
                      FilelistRemoveFileEvent(
                        fileName,
                      ),
                    );
              }
              return null;
            },
          );
        },
        onDismissed: (DismissDirection direction) {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  fileName,
                  style: context.textTheme.titleSmall,
                ),
              ),
            ),
            const Spacer(),
            FutureBuilder(
              future: context.read<FilelistBloc>().ownerImageUrl(ownerImageUrl),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: CustomErrorIcon());
                }
                if (snapshot.hasData) {
                  return CustomAvatarWidget(
                    imageUrl: snapshot.data as String,
                    size: 30,
                  );
                }
                return const Center(
                  child: CustomCircularProgressIndicator(
                    size: 30.0,
                  ),
                );
              },
            ),
            SizedBox(
              width: context.mediaQuery.size.width * RATIO_SPACE,
            ),
            Text(
              '${-date.difference(DateTime.now()).inDays} days ago',
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
