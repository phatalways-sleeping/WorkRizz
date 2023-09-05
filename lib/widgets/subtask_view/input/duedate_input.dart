import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';

class DueDateInputWidget extends StatefulWidget {
  const DueDateInputWidget({
    super.key,
    required this.execute,
    this.startFrom,
    this.restorationId,
  });

  final String? restorationId;
  final void Function(BuildContext, DateTime) execute;
  final DateTime? startFrom;

  @override
  State<DueDateInputWidget> createState() => _DueDateInputWidgetState();
}

class _DueDateInputWidgetState extends State<DueDateInputWidget>
    with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2023),
          lastDate: DateTime(2029),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        if (widget.startFrom == null ||
            (newSelectedDate.difference(widget.startFrom!).inDays > 0)) {
          _selectedDate.value = newSelectedDate;
          widget.execute(context, newSelectedDate);
        } else if (newSelectedDate.difference(widget.startFrom!).inDays < 0) {
          context.scaffoldMessenger.showSnackBar(
            SnackBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: context.mediaQuery.size.width * RATIO_PADDING * 1.2,
                vertical: context.mediaQuery.size.height * RATIO_PADDING,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 10.0,
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: context.colorScheme.onSecondary,
              content: DefaultTextStyle.merge(
                style: context.textTheme.bodySmall,
                child: const Text(
                  "End date must be greater than start date!",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          _restorableDatePickerRouteFuture.present();
        },
        // Container(
        //                             width: context.mediaQuery.size.width * 0.4,
        //                             margin: EdgeInsets.only(
        //                                 top: context.mediaQuery.size.width *
        //                                     0.01),
        //                             decoration: BoxDecoration(
        //                               // border black, size 1, round corner 12
        //                               border: Border.all(
        //                                 color: BLACK,
        //                                 width: BORDER_WIDTH,
        //                               ),
        //                               borderRadius:
        //                                   BorderRadius.circular(MEDIUM_CORNER),
        //                             ),
        //                             padding: EdgeInsets.all(
        //                                 MediaQuery.of(context).size.width *
        //                                     RATIO_PADDING),
        style: ButtonStyle(
          padding: MaterialStatePropertyAll(
            EdgeInsets.all(MediaQuery.of(context).size.width * RATIO_PADDING),
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MEDIUM_CORNER),
              side: const BorderSide(
                color: BLACK,
                width: 1,
              ),
            ),
          ),
          backgroundColor: const MaterialStatePropertyAll(WHITE)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.date_range_rounded, color: PALE),
            SizedBox(width: context.mediaQuery.size.width * RATIO_PADDING),
            DefaultTextStyle.merge(
              style: context.textTheme.bodyMedium,
              child: Text(
                "${convertMonthToString(_selectedDate.value.month)} ${_selectedDate.value.day}${_selectedDate.value.day == 1 ? 'st' : _selectedDate.value.day == 2 ? 'nd' : _selectedDate.value.day == 3 ? 'rd' : 'th'} ${_selectedDate.value.year}",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ));
  }
}
