import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';

class DateInputWidget extends StatefulWidget {
  const DateInputWidget({
    super.key,
    required this.text,
    required this.execute,
    this.startFrom,
    this.restorationId,
  });

  final String? restorationId;
  final String text;
  final void Function(BuildContext, DateTime) execute;
  final DateTime? startFrom;

  @override
  State<DateInputWidget> createState() => _DateInputWidgetState();
}

class _DateInputWidgetState extends State<DateInputWidget>
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
    return OutlinedButton(
      onPressed: () {
        _restorableDatePickerRouteFuture.present();
      },
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll(
          EdgeInsets.all(
            8.0,
          ),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              12.0,
            ),
            side: const BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
        ),
        overlayColor: MaterialStatePropertyAll(
          context.colorScheme.secondary,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle.merge(
            style: context.textTheme.bodySmall,
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(
            height: 3.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.date_range_rounded,
                size: 20.0,
                color: Colors.black,
              ),
              const SizedBox(
                width: 5.0,
              ),
              DefaultTextStyle.merge(
                style: context.textTheme.bodyMedium,
                child: Text(
                  "${convertMonthToString(_selectedDate.value.month)} - ${_selectedDate.value.day}${_selectedDate.value.day == 1 ? 'st' : _selectedDate.value.day == 2 ? 'nd' : _selectedDate.value.day == 3 ? 'rd' : 'th'} - ${_selectedDate.value.year}",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
