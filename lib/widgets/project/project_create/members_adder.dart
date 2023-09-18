import 'package:avatar_stack/avatar_stack.dart';
import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/email_dialog.dart';
import 'package:task_managing_application/widgets/custom_util_components/custom_circular_progress.dart';

enum MemberRole {
  common,
  leader,
}

class MembersAdder extends StatefulWidget {
  const MembersAdder({
    super.key,
    required this.role,
  });

  final MemberRole role;

  @override
  State<MembersAdder> createState() => _MembersAdderState();
}

class _MembersAdderState extends State<MembersAdder> {
  late final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        if (state is ProjectUserSubscription &&
            state is! ProjectUserCreateAndSubscribe) {
          return const SizedBox.shrink();
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTextStyle.merge(
              style: context.textTheme.bodyMedium,
              child: Text(
                widget.role == MemberRole.common ? 'Assignees' : 'Leader',
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
                if ((state as ProjectUserCreateAndSubscribe)
                        .newProjectSetup
                        .leaderImageUrl
                        .isEmpty &&
                    widget.role == MemberRole.leader)
                  const SizedBox.shrink()
                else if (state.newProjectSetup.assigneeImageUrls.isEmpty &&
                    widget.role == MemberRole.common)
                  const SizedBox.shrink()
                else ...[
                  FutureBuilder(
                    future: widget.role == MemberRole.common
                        ? context.read<ProjectBloc>().assigneeAvatars()
                        : context.read<ProjectBloc>().leaderAvatar(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Icon(
                          Icons.error,
                          color: context.colorScheme.error,
                          size: 10.0,
                        );
                      }
                      if (snapshot.hasData) {
                        if (widget.role == MemberRole.common) {
                          return AvatarStack(
                            avatars: snapshot.data as List<NetworkImage>,
                            width: 70.0,
                            height: 30.0,
                          );
                        }
                        return AvatarStack(
                          avatars: [snapshot.data as NetworkImage],
                          width: 70.0,
                          height: 30.0,
                        );
                      }
                      return const CustomCircularProgressIndicator(
                        size: 10.0,
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                ],
                InkWell(
                  onTap: () async {
                    await showDialog<String>(
                      context: context,
                      builder: (context) =>
                          EmailDialog(controller: _controller),
                    ).then(
                      (value) {
                        if (value != null && value.isNotEmpty) {
                          context.read<ProjectBloc>().add(
                              widget.role == MemberRole.leader
                                  ? ProjectInputLeader(value)
                                  : ProjectInputAssignee(value, context));
                          _controller.clear();
                        }
                      },
                    );
                  },
                  child: Container(
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
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
