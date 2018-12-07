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
    _paintLine(canvas, size);
    _paintBlock(canvas, size);
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

  _paintBlock(Canvas canvas, Size size) {
    Rect sliderRect =
        Offset(sliderPosition, size.height - 5.0) & Size(3.0, 10.0);
    canvas.drawRect(sliderRect, fillPainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
