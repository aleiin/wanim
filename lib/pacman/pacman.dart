import 'dart:math';

import 'package:flutter/material.dart';

class Pacman extends StatefulWidget {
  const Pacman({Key? key}) : super(key: key);

  @override
  _PacmanState createState() => _PacmanState();
}

class _PacmanState extends State<Pacman> with TickerProviderStateMixin {
  late AnimationController _animationController;

  late AnimationController _circleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _circleAnimation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animationController.repeat(reverse: true);
    // _circleAnimation.repeat();
    _circleAnimation = _animationController;
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 200),
      painter: PacmanPaint(
        pacmanAnimation: _animationController,
        circleAnimation: _circleAnimation,
        repaints: Listenable.merge([_animationController, _circleAnimation]),
        repaint: _animationController,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _circleAnimation.dispose();
    super.dispose();
  }
}

class PacmanPaint extends CustomPainter {
  PacmanPaint({
    this.angle = 50,
    required this.repaint,
    this.count = 5,
    required this.pacmanAnimation,
    required this.circleAnimation,
    required this.repaints,
  }) : super(repaint: repaints);

  final double angle;

  final Animation<double> repaint;

  final Animation<double> pacmanAnimation;

  final Animation<double> circleAnimation;

  final Listenable repaints;

  final int count;

  final _paint = Paint();

  double circleValue = 0;

  @override
  void paint(Canvas canvas, Size size) {
    /// 辅助
    canvas.drawRect(
      Offset.zero & size,
      Paint()..style = PaintingStyle.stroke,
    );

    canvas.clipRect(Offset.zero & size);

    // print('print 17:46: ${circleAnimation.value.toStringAsFixed(2)}');

    // print('print 17:41: ${pacmanAnimation.value.toStringAsFixed(2)}');

    // if (circleValue <= 0) {
    //   circleValue = pacmanAnimation.value;
    // } else if (circleValue >= 0.99) {
    //   circleValue = 1 - pacmanAnimation.value;
    // }
    //
    // print('print 09:23: ${circleValue}');

    canvas.save();

    var _perX = size.width / (count - 1);

    for (int i = 0; i < count * 2; i++) {
      var _x = _perX * i - size.width * circleAnimation.value;
      if (_x >= 0 && _x <= size.width) {
        canvas.drawCircle(
          Offset(_x, size.height / 2),
          3,
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
    var a = pacmanAnimation.value * angle / 180 * pi;

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
      oldDelegate.repaints != repaints;
}
