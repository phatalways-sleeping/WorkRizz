part of 'tasklist_view.dart';

class Date extends StatelessWidget {
  const Date({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  final DateTime startDate;
  final DateTime endDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tight(
        Size(
          context.mediaQuery.size.width,
          context.mediaQuery.size.height * 0.1,
        ),
      ),
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: BLACK,
            width: BORDER_WIDTH,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(MEDIUM_CORNER),
          ),
        ),
      ),
      padding: EdgeInsets.only(
        left: context.mediaQuery.size.width * RATIO_PADDING,
        right: context.mediaQuery.size.width * RATIO_PADDING,
        bottom: context.mediaQuery.size.width * RATIO_PADDING * 1.7,
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  convertDayToString(
                    startDate.day,
                  ),
                  style: context.textTheme.titleLarge),
              Text(
                  convertMonthToFullString(
                    startDate.month,
                  ),
                  style: context.textTheme.bodyMedium)
            ],
          ),
          const Spacer(
            flex: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: const ShapeDecoration(
                  color: PINK,
                  shape: CircleBorder(
                    side: BorderSide(
                      color: BLACK,
                      width: 2.0,
                    ),
                  ),
                ),
                padding: const EdgeInsets.all(1.0),
                child: const Icon(Icons.arrow_forward_outlined),
              ),
              SizedBox(
                height: context.mediaQuery.size.height * 0.01,
              )
            ],
          ),
          const Spacer(
            flex: 4,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                convertDayToString(
                  endDate.day,
                ),
                style: context.textTheme.titleLarge,
              ),
              Text(
                convertMonthToFullString(
                  endDate.month,
                ),
                style: context.textTheme.bodyMedium,
              )
            ],
          ),
        ],
      ),
    );
  }
}
