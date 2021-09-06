import 'dart:math';

import 'package:flutter/material.dart';

class Cross extends StatefulWidget {
  const Cross({Key? key}) : super(key: key);

  @override
  _CrossState createState() => _CrossState();
}

class _CrossState extends State<Cross> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 200),
      painter: CrossPaint(animation: _animationController),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class CrossPaint extends CustomPainter {
  CrossPaint({required this.animation}) : super(repaint: animation);

  Animation<double> animation;

  Paint _paint = Paint();

  final List<Color> colors = const [
    Color(0xffF44336),
    Color(0xff5C6BC0),
    Color(0xffFFB74D),
    Color(0xff8BC34A),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawRect(
    //   Offset.zero & size,
    //   Paint()..color = Colors.grey.withAlpha(110),
    // );

    Path path = Path();

    path.moveTo(size.width / 2, 0);
    path.relativeLineTo(0, size.height);

    path.moveTo(0, size.height / 2);
    path.relativeLineTo(size.width, 0);

    canvas.drawPath(path, Paint()..style = PaintingStyle.stroke);

    canvas.translate(size.width / 2, size.height / 2);

    canvas.drawRect(
        Rect.fromCenter(
          center: Offset.zero,
          width: size.shortestSide,
          height: size.shortestSide,
        ),
        Paint()..style = PaintingStyle.stroke);

    double side = size.shortestSide / 4;

    /// canvas.translate(0, -side * 2 + side / sqrt(2));
    // final offset = -side * 2 + (side * sqrt(2) / 2);

    final double begin = -side * 2 + (side * sqrt(2) / 2);
    final double end = side * 2 + (side * sqrt(2) / 2);

    // _drawItem(
    //   canvas: canvas,
    //   offset: offset,
    //   side: side,
    //   isXAxis: true,
    //   color: colors[0],
    // );
    // _drawItem(
    //   canvas: canvas,
    //   offset: -offset,
    //   side: side,
    //   isXAxis: true,
    //   color: colors[1],
    // );
    // _drawItem(
    //   canvas: canvas,
    //   offset: offset,
    //   side: side,
    //   isXAxis: false,
    //   color: colors[2],
    // );
    // _drawItem(
    //   canvas: canvas,
    //   offset: -offset,
    //   side: side,
    //   isXAxis: false,
    //   color: colors[3],
    // );
    _handleAnimation(
      canvas: canvas,
      begin: begin,
      end: end,
      side: side,
      isXAxis: true,
      color: colors[0],
    );
    _handleAnimation(
      canvas: canvas,
      begin: -begin,
      end: -end,
      side: side,
      isXAxis: true,
      color: colors[1],
    );
    _handleAnimation(
      canvas: canvas,
      begin: begin,
      end: end,
      side: side,
      isXAxis: false,
      color: colors[2],
    );
    _handleAnimation(
      canvas: canvas,
      begin: -begin,
      end: -end,
      side: side,
      isXAxis: false,
      color: colors[3],
    );
  }

  void _handleAnimation({
    required Canvas canvas,
    required double begin,
    required double end,
    required double side,
    Color color = Colors.black,
    bool isXAxis = true,
    Curve curve = Curves.easeIn,
  }) {
    Animatable<double> tween = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem(tween: Tween(begin: begin, end: end), weight: 1),
        TweenSequenceItem(tween: Tween(begin: end, end: begin), weight: 1),
      ],
    ).chain(CurveTween(curve: curve));

    _drawItem(
      canvas: canvas,
      offset: tween.evaluate(animation),
      side: side,
      color: color,
      isXAxis: isXAxis,
    );
  }

  void _drawItem({
    required Canvas canvas,
    required double offset,
    required double side,
    Color color = Colors.black,
    bool isXAxis = true,
  }) {
    canvas.save();

    if (isXAxis) {
      canvas.translate(offset, 0);
    } else {
      canvas.translate(0, offset);
    }

    canvas.rotate(45 / 180 * pi);

    canvas.drawRect(
      Rect.fromCenter(center: Offset.zero, width: side, height: side),
      _paint..color = color,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CrossPaint oldDelegate) =>
      oldDelegate.animation != animation;
}
