import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/models/models.dart';
import 'package:task_managing_application/states/project_bloc/project_bloc.dart';
import 'package:task_managing_application/widgets/authentication/components.dart';

import 'project_tag.dart';

class TagsAdder extends StatefulWidget {
  const TagsAdder({super.key});

  @override
  State<TagsAdder> createState() => _TagsAdderState();
}

class _TagsAdderState extends State<TagsAdder> {
  late final TextEditingController _controller = TextEditingController();

  List<Row> _buildTags(List<Tag> tags) {
    final List<Row> rows = List.empty(growable: true);

    int startIndex = 0;
    while (startIndex < tags.length) {
      int endIndex =
          startIndex + 3 >= tags.length ? tags.length : startIndex + 3;
      final List<ProjectTagWidget> tagsWidget = List.empty(growable: true);
      while (startIndex < endIndex) {
        tagsWidget.add(ProjectTagWidget(tag: tags[startIndex]));
        startIndex += 1;
      }
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: tagsWidget,
        ),
      );
    }

    return rows;
  }

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultTextStyle.merge(
              style: context.textTheme.bodySmall,
              child: Text(
                'Tag',
                style: TextStyle(
                  color: context.colorScheme.onSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: context.mediaQuery.size.height * RATIO_PADDING * 0.3,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: _buildTags(
                    (state as ProjectUserCreateAndSubscribe)
                        .newProjectSetup
                        .tags,
                  ),
                ),
                SizedBox(
                  width: context.mediaQuery.size.width * RATIO_PADDING * 0.5,
                ),
                InkWell(
                  onTap: () async {
                    await showDialog<String>(
                      context: context,
                      builder: (context) => _TagDialog(controller: _controller),
                    ).then(
                      (value) {
                        if (value != null && value.isNotEmpty) {
                          context.read<ProjectBloc>().add(
                                ProjectInputTag(
                                  Tag(
                                    title: value.trim(),
                                  ),
                                ),
                              );
                          _controller.clear();
                        }
                      },
                    );
                  },
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: ShapeDecoration(
                      color: context.colorScheme.onPrimary,
                      shape: const OvalBorder(
                        side: BorderSide(
                          width: 1.50,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        ),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 18.0,
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}

class _TagDialog extends StatelessWidget {
  const _TagDialog({
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
              CustomInputField(
                label: "Add a tag",
                controller: _controller,
                keyboardType: TextInputType.name,
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
