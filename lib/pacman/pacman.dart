import 'dart:math';

import 'package:flutter/material.dart';

class Pacman extends StatefulWidget {
  const Pacman({Key? key}) : super(key: key);

  @override
  _PacmanState createState() => _PacmanState();
}

class _PacmanState extends State<Pacman> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 200),
      painter: PacmanPaint(
        repaint: _animationController,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class PacmanPaint extends CustomPainter {
  PacmanPaint({
    this.angle = 50,
    required this.repaint,
    this.count = 5,
  }) : super(repaint: repaint);

  final double angle;

  final Animation<double> repaint;

  final int count;

  final _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    /// 辅助
    canvas.drawRect(
      Offset.zero & size,
      Paint()..style = PaintingStyle.stroke,
    );

    canvas.clipRect(Offset.zero & size);

    canvas.save();

    var _perX = size.width / (count - 1);

    for (int i = 0; i < count * 2; i++) {
      var _x = _perX * i -
          size.width *
              (repaint.status == AnimationStatus.forward
                  ? repaint.value
                  : 1 - repaint.value);

      if (_x >= 0 && _x <= size.width) {
        canvas.drawCircle(
          Offset(_x, size.height / 2),
          10,
          Paint()..color = Colors.blue,
        );
      }
    }

    canvas.restore();

    canvas.save();

    final double radius = size.shortestSide / 2;
    canvas.translate(size.width / 2, size.height / 2);
    _drawHead(canvas, size);
    _drawEye(canvas, radius);

    canvas.restore();
  }

  /// 绘制头
  void _drawHead(Canvas canvas, Size size) {
    Rect rect = Rect.fromCenter(
      center: Offset.zero,
      width: size.width,
      height: size.height,
    );
    var a = repaint.value * angle / 180 * pi;

    canvas.drawArc(
      rect,
      a,
      2 * pi - a.abs() * 2,
      true,
      _paint..color = Colors.blue,
    );
  }

  /// 绘制眼睛
  void _drawEye(Canvas canvas, double radius) {
    canvas.drawCircle(
      Offset(radius * 0.15, -radius * 0.6),
      radius * 0.12,
      _paint..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant PacmanPaint oldDelegate) =>
      oldDelegate.repaint != repaint;
}
