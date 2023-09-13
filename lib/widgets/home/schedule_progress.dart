import 'package:flutter/material.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'dart:async';
import 'dart:math';
import 'schedule_dbms.dart';

class ScheduleProgress extends StatefulWidget {
  const ScheduleProgress({
    super.key,
  });
  @override
  State<ScheduleProgress> createState() => _ScheduleProgressState();
}

class _ScheduleProgressState extends State<ScheduleProgress> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.mediaQuery.size.width * 0.7,
      height: context.mediaQuery.size.width * 0.7,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: SchedulePainter(),
        ),
      ),
    );
  }
}

class SchedulePainter extends CustomPainter {
  var dateTime = DateTime.now();
  var schedule = ScheduleData();
  //60 sec - 360, 1 sec - 6degree
  //12 hours  - 360, 1 hour - 30degrees, 1 min - 0.5degrees

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    // ignore: unused_local_variable
    var outerCircleRadius = radius;
    var innerCircleRadius = radius;

    Rect myRect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius - 14);

    var fillBrush = Paint()..color = const Color(0xFF444974);

    // ignore: unused_local_variable
    var outlineBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    var centerFillBrush = Paint()..color = const Color(0xFFEAECFF);

    var secHandBrush = Paint()
      ..color = Colors.orange[300]!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    var minHandBrush = Paint()
      ..shader = const RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    var hourHandBrush = Paint()
      ..shader = const RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;

    var dashBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    var startAngle = -30 * pi / 180;
    var sweepAngle = pi / 180.0 * (360.0 / 12.0);

    for (double i = 0; i < 12; i += 1) {
      var paintcolor = Paint()
        ..color = schedule.taskColor[i.toInt()]
        ..strokeWidth = 4
        ..style = PaintingStyle.fill
        ..strokeCap = StrokeCap.round;

      startAngle += sweepAngle;
      canvas.drawArc(myRect, startAngle, sweepAngle, true, paintcolor);
    }
    canvas.drawCircle(center, radius - 40, fillBrush);
    //canvas.drawCircle(center, radius - 40, outlineBrush);

    var hourHandX = centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var secHandX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, 16, centerFillBrush);

    for (double i = 0; i < 12; i += 1) {
      var x1 = centerX + (innerCircleRadius - 55) * cos(i * 30 * pi / 180);
      var y1 = centerX + (innerCircleRadius - 55) * sin(i * 30 * pi / 180);

      var x2 = centerX + (innerCircleRadius - 45) * cos(i * 30 * pi / 180);
      var y2 = centerX + (innerCircleRadius - 45) * sin(i * 30 * pi / 180);
      startAngle += sweepAngle;
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
