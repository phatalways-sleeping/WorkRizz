import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';

String convertWeekdayToString(int weekDay) {
  switch (weekDay) {
    case 1:
      return "Monday";
    case 2:
      return "Tuesday";
    case 3:
      return "Wednesday";
    case 4:
      return "Thursday";
    case 5:
      return "Friday";
    case 6:
      return "Saturday";
    case 7:
      return "Sunday";
    default:
      return "";
  }
}

String convertMonthToString(int month) {
  switch (month) {
    case 1:
      return "Jan";
    case 2:
      return "Feb";
    case 3:
      return "Mar";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "Jun";
    case 7:
      return "Jul";
    case 8:
      return "Aug";
    case 9:
      return "Sep";
    case 10:
      return "Oct";
    case 11:
      return "Nov";
    case 12:
      return "Dec";
    default:
      return "";
  }
}

String convertDayToString(int day) {
  switch (day) {
    case 1:
      return "1st";
    case 2:
      return "2nd";
    case 3:
      return "3rd";
    default:
      return "${day}th";
  }
}

String convertMonthToFullString(int month) {
  switch (month) {
    case 1:
      return "January";
    case 2:
      return "Febuary";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "Jun";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "October";
    case 11:
      return "November";
    case 12:
      return "Decemeber";
    default:
      return "";
  }
}

String calculateDaysLeft(DateTime date) {
  final now = DateTime.now();
  final difference = date.difference(now);
  if(difference.inDays < 0) return 'Expired';
  return '${difference.inDays} ${difference.inDays > 1 ? 'days' : 'day'} left';
}

Color calculateColor(DateTime date) {
  final now = DateTime.now();
  final difference = date.difference(now);
  if(difference.inDays < 0) return PALE;
  if(difference.inDays < 3) return ORANGE;
  return GREY;
}
