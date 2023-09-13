import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/widgets/custom_tag/project_tag.dart';

class SubTaskButton extends StatelessWidget {
  const SubTaskButton({
    super.key,
    required this.color,
    required this.name,
    required this.description,
  });

  final Color color;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0.0),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.all(context.mediaQuery.size.width * RATIO_PADDING),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MEDIUM_CORNER * 2),
          ),
        ),
        fixedSize: MaterialStatePropertyAll(
          Size(
            context.mediaQuery.size.width * 0.40,
            context.mediaQuery.size.width * 0.30,
          ),
        ),
        side: const MaterialStatePropertyAll(
          BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
      ),
      onPressed: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ProjectTag(
            color: color,
            name: name,
          ),
          SizedBox(
            height: context.mediaQuery.size.width * RATIO_SPACE * 0.5,
          ),
          SizedBox(
            height: context.mediaQuery.size.width * 0.16,
            child: Text(
              description,
              style: context.textTheme.bodyMedium,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
