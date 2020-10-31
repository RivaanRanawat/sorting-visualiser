import 'package:flutter/cupertino.dart';

class BarPainter extends CustomPainter {
  final double width;
  final int value;
  final int index;

  BarPainter({this.width, this.value, this.index});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    if (this.value < 500 * 0) {
      paint.color = Color.fromRGBO(0, 0, 66, 0.75);
    } else if (this.value < 500 * .50) {
      paint.color = Color.fromRGBO(17, 104, 217, 0.75);
    } else if (this.value < 500 * .75) {
      paint.color = Color.fromRGBO(0, 217, 159, 0.75);
    } else if (this.value < 500 * .90) {
      paint.color = Color.fromRGBO(0, 190, 218, 0.75);
    }
    paint.strokeWidth = width;
    paint.strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(index * width, 0),
        Offset(index * width, value.ceilToDouble()), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
