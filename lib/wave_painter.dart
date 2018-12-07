import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  final double sliderPosition;
  final double dragPercentage;

  final Color color;

  final Paint wavePainter;
  final Paint fillPainter;

  WavePainter(
      {@required this.sliderPosition,
      @required this.dragPercentage,
      @required this.color})
      : wavePainter = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5,
        fillPainter = Paint()
          ..color = color
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    _paintAnchors(canvas, size);
    _paintWaveLine(canvas, size);
  }

  _paintAnchors(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(0.0, size.height), 5.0, fillPainter);
    canvas.drawCircle(Offset(size.width, size.height), 5.0, fillPainter);
  }

  _paintLine(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    canvas.drawPath(path, wavePainter);
  }

  _paintWaveLine(Canvas canvas, Size size) {
    // Wave-line definitions.
    double bendWidth = 40.0;
    double bezierWidth = 40.0;

    double startOfBend = sliderPosition - bendWidth / 2;
    double startOfBezier = startOfBend - bezierWidth;
    double endOfBend = sliderPosition + bendWidth / 2;
    double endOfBezier = endOfBend + bezierWidth;

    double controlHeight = 0.0;
    double centerPoint = sliderPosition;

    double leftControlPoint1 = startOfBend;
    double leftControlPoint2 = startOfBend;
    double rightControlPoint1 = endOfBend;
    double rightControlPoint2 = endOfBend;

    double bendValue = 0.0;
    bool moveLeft = false;

    if (moveLeft) {
      leftControlPoint1 = leftControlPoint1 + bendValue;
      leftControlPoint2 = leftControlPoint2 + bendValue / 2;
      rightControlPoint1 = rightControlPoint1 + bendValue;
      rightControlPoint2 = rightControlPoint2 - bendValue;

      centerPoint = centerPoint + bendValue;
    } else {
      leftControlPoint1 = leftControlPoint1 + bendValue;
      leftControlPoint2 = leftControlPoint2 - bendValue;
      rightControlPoint1 = rightControlPoint1 - bendValue / 2;
      rightControlPoint2 = rightControlPoint2 - bendValue;

      centerPoint = centerPoint - bendValue;
    }

    Path path = Path();
    path.moveTo(0.0, size.height);
    path.lineTo(startOfBezier, size.height);
    path.cubicTo(leftControlPoint1, size.height, leftControlPoint2,
        controlHeight, centerPoint, controlHeight);
    path.cubicTo(rightControlPoint1, controlHeight, rightControlPoint2,
        size.height, endOfBezier, size.height);
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, wavePainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
