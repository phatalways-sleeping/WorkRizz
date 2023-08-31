part of 'tasklist_view.dart';

class Progress extends StatelessWidget {
  const Progress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MEDIUM_CORNER),
        border: Border.all(color: BLACK, width: BORDER_WIDTH),
      ),
      padding:
          EdgeInsets.all(MediaQuery.of(context).size.width * RATIO_PADDING),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(
              color: GREEN,
              shape: BoxShape.circle,
              border: Border.all(color: BLACK, width: BORDER_WIDTH),
            ),
            // size bound its child
            padding: EdgeInsets.all(
                MediaQuery.of(context).size.width * RATIO_PADDING),
            child: SizedBox(child: Text("pp%", style: context.textTheme.titleSmall)),
          ),
          Column(
            children: [
              Text(
                "xx/xx",
                style: context.textTheme.titleLarge,
              ),
              Text(
                "Task",
                style: context.textTheme.bodyMedium,
              )
            ],
          ),
          Column(
            children: [
              Text(
                "xx/xx",
                style: context.textTheme.titleLarge,
              ),
              Text(
                "Task",
                style: context.textTheme.bodyMedium,
              )
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    "ava1 ",
                    style: context.textTheme.titleLarge,
                  ),
                  Text(
                    "ava2 ",
                    style: context.textTheme.titleLarge,
                  ),
                ],
              ),
              Text(
                "Most Active",
                style: context.textTheme.bodyMedium,
              )
            ],
          ),
        ],
      ),
    );
  }
}
