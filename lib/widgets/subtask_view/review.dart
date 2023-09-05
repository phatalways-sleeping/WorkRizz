part of 'subtask_view.dart';

class Review extends StatefulWidget {
  const Review({super.key, required this.isAssigned});
  final bool isAssigned;

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  late final TextEditingController _titleController;
  late final FocusNode _focusNode = FocusNode()..addListener(() {});

  @override
  void initState() {
    _titleController = TextEditingController();
    _titleController.addListener(() {
      if (_titleController.text.isNotEmpty) {
        // context
        //     .read<ProjectBloc>()
        //     .add(ProjectInputName(_titleController.text));
      }
    });
    // _titleController.text =
    //     (context.read<ProjectBloc>().state as ProjectUserCreateAndSubscribe)
    //         .newProjectSetup
    //         .name;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Review', style: context.textTheme.labelMedium),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: context.mediaQuery.size.width * 0.4,
                margin:
                    EdgeInsets.only(top: context.mediaQuery.size.width * 0.01),
                decoration: BoxDecoration(
                  // border black, size 1, round corner 12
                  border: Border.all(
                    color: BLACK,
                    width: BORDER_WIDTH,
                  ),
                  borderRadius: BorderRadius.circular(MEDIUM_CORNER),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width * RATIO_PADDING,
                    horizontal:
                        MediaQuery.of(context).size.width * RATIO_PADDING * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.isAssigned
                        ? const TextInput(
                            suffixText: "%",
                            color: PINK,
                          )
                        : Text('xx%',
                            style: context.textTheme.displaySmall
                                ?.copyWith(color: BLACK)),
                    SizedBox(
                        width: context.mediaQuery.size.width * RATIO_PADDING),
                    Text('Completed', style: context.textTheme.titleSmall),
                  ],
                )),
            Container(
                width: context.mediaQuery.size.width * 0.4,
                margin:
                    EdgeInsets.only(top: context.mediaQuery.size.width * 0.01),
                decoration: BoxDecoration(
                  // border black, size 1, round corner 12
                  border: Border.all(
                    color: BLACK,
                    width: BORDER_WIDTH,
                  ),
                  borderRadius: BorderRadius.circular(MEDIUM_CORNER),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width * RATIO_PADDING,
                    horizontal:
                        MediaQuery.of(context).size.width * RATIO_PADDING * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.isAssigned
                        ? const TextInput(
                            suffixText: "/10",
                            color: PALE,
                          )
                        : Text('x/10',
                            style: context.textTheme.displaySmall
                                ?.copyWith(color: BLACK)),
                    SizedBox(
                        width: context.mediaQuery.size.width * RATIO_PADDING),
                    Text('Points', style: context.textTheme.titleSmall),
                  ],
                )),
          ],
        ),
        SizedBox(height: context.mediaQuery.size.width * RATIO_SPACE),
        widget.isAssigned
            ? const DescriptionInput(
                label: "Leader's Review", showLabel: true,
              )
            : Container(
                // width: max available width, finite
                constraints: BoxConstraints(
                  minHeight: context.mediaQuery.size.height * 0.1,
                ),
                margin:
                    EdgeInsets.only(top: context.mediaQuery.size.width * 0.01),
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
                child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nisl eget nunc aliquam aliquet.',
                    style: context.textTheme.titleSmall),
              ),
        SizedBox(height: context.mediaQuery.size.width * RATIO_SPACE),
        // CustomInputField(label: "", controller: _titleController, keyboardType: TextInputType.number),
      ],
    );
  }
}
