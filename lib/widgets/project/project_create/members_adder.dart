import 'package:avatar_stack/avatar_stack.dart';
import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/project_bloc/project_bloc.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/authentication/components.dart';
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
            BlocBuilder<ProjectBloc, ProjectState>(
              buildWhen: (previous, current) {
                if (widget.role == MemberRole.common) {
                  return (previous as ProjectUserCreateAndSubscribe)
                          .newProjectSetup
                          .assigneeImageUrls !=
                      (current as ProjectUserCreateAndSubscribe)
                          .newProjectSetup
                          .assigneeImageUrls;
                }
                return (previous as ProjectUserCreateAndSubscribe)
                        .newProjectSetup
                        .leaderImageUrl !=
                    (current as ProjectUserCreateAndSubscribe)
                        .newProjectSetup
                        .leaderImageUrl;
              },
              builder: (context, state) {
                if ((state as ProjectUserCreateAndSubscribe)
                        .newProjectSetup
                        .leaderImageUrl
                        .isEmpty &&
                    widget.role == MemberRole.leader) {
                  return const SizedBox.shrink();
                }
                if (state.newProjectSetup.assigneeImageUrls.isEmpty &&
                    widget.role == MemberRole.common) {
                  return const SizedBox.shrink();
                }
                return FutureBuilder(
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
                );
              },
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () async {
                await showDialog<String>(
                  context: context,
                  builder: (context) => _EmailDialog(controller: _controller),
                ).then(
                  (value) {
                    if (value != null && value.isNotEmpty) {
                      context.read<ProjectBloc>().add(
                          widget.role == MemberRole.leader
                              ? ProjectInputLeader(value)
                              : ProjectInputAssignee(value));
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
  }
}

class _EmailDialog extends StatelessWidget {
  const _EmailDialog({
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.4),
      body: Center(
        child: Container(
          width: context.mediaQuery.size.width * 0.9,
          height: context.mediaQuery.size.height * 0.2,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2.0),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DefaultTextStyle.merge(
                style: context.textTheme.displaySmall,
                child: const Text(
                  'Add person',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomInputField(
                label: "Email",
                controller: _controller,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 7),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(_controller.text),
                  style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(
                        vertical:
                            context.mediaQuery.size.height * RATIO_MARGIN * 0.2,
                      ),
                    ),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    backgroundColor: const MaterialStatePropertyAll(
                      Colors.black,
                    ),
                    overlayColor: MaterialStatePropertyAll(
                      context.colorScheme.primary,
                    ),
                    alignment: Alignment.center,
                    fixedSize: MaterialStatePropertyAll(
                      Size(
                        context.mediaQuery.size.width * 0.9,
                        context.mediaQuery.size.height * 0.05,
                      ),
                    ),
                  ),
                  child: DefaultTextStyle.merge(
                    style: context.textTheme.bodyLarge,
                    child: const Text(
                      'Done',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
