import 'dart:ui';

import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  final double sliderPosition;
  final double dragPercentage;

  final Color color;

  final Paint wavePainter;
  final Paint fillPainter;

  /// Previous slider position initialised at 0.0
  double _previousSliderPosition = 0.0;

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
    WaveCurveDefinitions waveCurve = _calculateWaveLineDefinitions();

    Path path = Path();
    path.moveTo(0.0, size.height);
    path.lineTo(waveCurve.startOfBezier, size.height);
    path.cubicTo(
        waveCurve.leftControlPoint1,
        size.height,
        waveCurve.leftControlPoint2,
        waveCurve.controlHeight,
        waveCurve.centerPoint,
        waveCurve.controlHeight);
    path.cubicTo(
        waveCurve.rightControlPoint1,
        waveCurve.controlHeight,
        waveCurve.rightControlPoint2,
        size.height,
        waveCurve.endOfBezier,
        size.height);
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, wavePainter);
  }

  WaveCurveDefinitions _calculateWaveLineDefinitions() {
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

    double bendability = 25.0;
    double maxSlideDifference = 20.0;
    double slideDifference = (sliderPosition - _previousSliderPosition).abs();
    if (slideDifference > maxSlideDifference) {
      slideDifference = maxSlideDifference;
    }

    double bend =
        lerpDouble(0.0, bendability, slideDifference / maxSlideDifference);

    bool moveLeft = sliderPosition < _previousSliderPosition;
    if (moveLeft) {
      leftControlPoint1 = leftControlPoint1 - bend;
      leftControlPoint2 = leftControlPoint2 + bend;
      rightControlPoint1 = rightControlPoint1 + bend;
      rightControlPoint2 = rightControlPoint2 - bend;
      centerPoint = centerPoint + bend;
    } else {
      leftControlPoint1 = leftControlPoint1 + bend;
      leftControlPoint2 = leftControlPoint2 - bend;
      rightControlPoint1 = rightControlPoint1 - bend;
      rightControlPoint2 = rightControlPoint2 + bend;

      centerPoint = centerPoint - bend;
    }

    WaveCurveDefinitions waveCurveDefinitions = WaveCurveDefinitions(
      controlHeight: controlHeight,
      startOfBezier: startOfBezier,
      endOfBezier: endOfBezier,
      leftControlPoint1: leftControlPoint1,
      leftControlPoint2: leftControlPoint2,
      rightControlPoint1: rightControlPoint1,
      rightControlPoint2: rightControlPoint2,
      centerPoint: centerPoint,
    );

    return waveCurveDefinitions;
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) {
    this._previousSliderPosition = oldDelegate.sliderPosition;
    if (sliderPosition != oldDelegate.sliderPosition) {
      return true;
    } else {
      return false;
    }
  }
}

class WaveCurveDefinitions {
  final double startOfBezier;
  final double endOfBezier;
  final double leftControlPoint1;
  final double leftControlPoint2;
  final double rightControlPoint1;
  final double rightControlPoint2;
  final double controlHeight;
  final double centerPoint;

  WaveCurveDefinitions({
    @required this.startOfBezier,
    @required this.endOfBezier,
    @required this.leftControlPoint1,
    @required this.leftControlPoint2,
    @required this.rightControlPoint1,
    @required this.rightControlPoint2,
    @required this.controlHeight,
    @required this.centerPoint,
  });
}
