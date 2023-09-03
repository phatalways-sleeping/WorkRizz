import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';

enum MemberRole {
  common,
  leader,
}

class MembersAdder extends StatelessWidget {
  const MembersAdder({
    super.key,
    required this.role,
  });

  final MemberRole role;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTextStyle.merge(
          style: context.textTheme.bodyMedium,
          child: Text(
            role == MemberRole.common ? 'Assignees' : 'Leader',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 21,
              height: 20,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://via.placeholder.com/21x20"),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 21,
              height: 20,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://via.placeholder.com/21x20"),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 25.0,
              height: 25.0,
              decoration: const ShapeDecoration(
                color: Colors.black,
                shape: OvalBorder(),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
