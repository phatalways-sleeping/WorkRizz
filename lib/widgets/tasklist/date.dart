part of 'tasklist_view.dart';
class Date extends StatelessWidget {
  const Date({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MEDIUM_CORNER),
        border: Border.all(color: BLACK, width: BORDER_WIDTH),
      ),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * RATIO_PADDING),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Start date",
                style: context.textTheme.titleLarge
              ),
              Text(
                "Start month",
                style: context.textTheme.bodyMedium
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: PINK,
              shape: BoxShape.circle,
              border: Border.all(color: BLACK, width: BORDER_WIDTH),
            ),
            child: const Icon(Icons.arrow_forward_outlined),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Start date",
                style: context.textTheme.titleLarge
              ),
              Text(
                "Start month",
                style: context.textTheme.bodyMedium
              )
            ],
          ),
        ],
      ),
    );
  }
}
