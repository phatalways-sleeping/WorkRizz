import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/states/subtask_create_bloc/subtask_create_bloc.dart';
import 'package:task_managing_application/widgets/authentication/components.dart';
import 'package:task_managing_application/widgets/custom_avatar_widget/future_avatar_widget.dart';
import 'package:task_managing_application/widgets/custom_util_components/custom_circular_progress.dart';

class AssigneeAdder extends StatefulWidget {
  const AssigneeAdder({
    super.key,
  });

  @override
  State<AssigneeAdder> createState() => _AssigneeAdderState();
}

class _AssigneeAdderState extends State<AssigneeAdder> {
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
        BlocBuilder<SubtaskCreateBloc, SubtaskCreateState>(
          builder: (context, state) {
            if (state is SubtaskCreateInitial ||
                state is SubtaskCreateFailureDueToNetwork ||
                state is SubTaskCreateFailureDueToDataIntegrity) {
              return const SizedBox.shrink();
            }
            return Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if ((state as SubtaskCreateSuccess).assignedTo == null ||
                    state.assignedTo!.isEmpty)
                  const SizedBox.shrink()
                else
                  FutureBuilder(
                    future: context.read<SubtaskCreateBloc>().assigneeImage(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Icon(
                          Icons.error,
                          color: context.colorScheme.error,
                          size: 20.0,
                        );
                      }
                      if (snapshot.hasData) {
                        return FutureAvatarWidget(
                          avatarRatio: 0.04,
                          radiusRatio: 0.02,
                          imageUrl: snapshot.data as String,
                          onTap: (context) {},
                        );
                      }
                      return const CustomCircularProgressIndicator(
                        size: 10.0,
                      );
                    },
                  ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () async {
                    await showDialog<String>(
                      context: context,
                      builder: (context) =>
                          _EmailDialog(controller: _controller),
                    ).then(
                      (value) {
                        if (value != null && value.isNotEmpty) {
                          context
                              .read<SubtaskCreateBloc>()
                              .add(SubTaskInputAssignedToEvent(value));
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
            );
          },
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
          constraints: BoxConstraints(
            maxWidth: context.mediaQuery.size.width * 0.9,
            maxHeight: context.mediaQuery.size.height * 0.4,
          ),
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
              SizedBox(
                height: context.mediaQuery.size.height * 0.01,
              ),
              CustomInputField(
                label: "Email",
                controller: _controller,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: context.mediaQuery.size.height * 0.01,
              ),
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
                    minimumSize: MaterialStatePropertyAll(
                      Size(
                        context.mediaQuery.size.width * 0.9,
                        context.mediaQuery.size.height * 0.02,
                      ),
                    ),
                    maximumSize: MaterialStatePropertyAll(
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
