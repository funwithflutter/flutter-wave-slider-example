import 'package:flutter/material.dart';
import 'package:wave_slider/wave_painter.dart';

class WaveSlider extends StatefulWidget {
  final double sliderWidth;
  final double sliderHeight;

  final Color color;

  WaveSlider({
    this.sliderWidth = 350.0,
    this.sliderHeight = 50.0,
    this.color = Colors.black,
  });

  @override
  _WaveSliderState createState() => _WaveSliderState();
}

class _WaveSliderState extends State<WaveSlider> {
  double _dragPosition = 0.0;
  double _dragPercentage = 0.0;

  void _updateDragPosition(Offset val) {
    double newDragPosition = 0.0;
    if (val.dx <= 0.0) {
      newDragPosition = 0.0;
    } else if (val.dx >= widget.sliderWidth) {
      newDragPosition = widget.sliderWidth;
    } else {
      newDragPosition = val.dx;
    }

    setState(() {
      _dragPosition = newDragPosition;
      _dragPercentage = _dragPosition / widget.sliderWidth;
    });
  }

  void _onDragStart(BuildContext context, DragStartDetails start) {
    RenderBox box = context.findRenderObject();
    Offset localOffset = box.globalToLocal(start.globalPosition);
    _updateDragPosition(localOffset);
  }

  void _onDragUpdate(BuildContext context, DragUpdateDetails update) {
    RenderBox box = context.findRenderObject();
    Offset localOffset = box.globalToLocal(update.globalPosition);
    _updateDragPosition(localOffset);
  }

  void _onDragEnd(BuildContext context, DragEndDetails end) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: widget.sliderWidth,
        height: widget.sliderHeight,
        child: CustomPaint(
          painter: WavePainter(
            color: widget.color,
            sliderPosition: _dragPosition,
            dragPercentage: _dragPercentage,
          ),
        ),
      ),
      onHorizontalDragStart: (DragStartDetails start) =>
          _onDragStart(context, start),
      onHorizontalDragUpdate: (DragUpdateDetails update) =>
          _onDragUpdate(context, update),
      onHorizontalDragEnd: (DragEndDetails end) => _onDragEnd(context, end),
    );
  }
}
