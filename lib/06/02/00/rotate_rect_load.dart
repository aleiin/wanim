import 'dart:math';

import 'package:flutter/material.dart';

class RotateRectLoad extends StatefulWidget {
  const RotateRectLoad({Key? key}) : super(key: key);

  @override
  _RotateRectLoadState createState() => _RotateRectLoadState();
}

class _RotateRectLoadState extends State<RotateRectLoad>
    with SingleTickerProviderStateMixin {
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
      painter: RotateRectLoadPaint(animation: _animationController),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class RotateRectLoadPaint extends CustomPainter {
  RotateRectLoadPaint({required this.animation}) : super(repaint: animation);

  Animation<double> animation;

  final Animatable<double> rotateTween =
      Tween<double>(begin: pi, end: -pi).chain(
    CurveTween(curve: Curves.easeIn),
  );

  Paint _paint = Paint();
  final List<Color> colors = const [
    Color(0xffF44336),
    Color(0xff5C6BC0),
    Color(0xffFFB74D),
    Color(0xff8BC34A)
  ];

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(size.width / 2, 0);
    path.relativeLineTo(0, size.height);
    path.moveTo(0, size.height / 2);
    path.relativeLineTo(size.width, 0);

    canvas.drawPath(path, Paint()..style = PaintingStyle.stroke);

    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(animation.value * 2 * pi);
    double radius = size.shortestSide;
    canvas.drawRect(
      Rect.fromCenter(center: Offset.zero, width: radius, height: radius),
      Paint()..style = PaintingStyle.stroke,
    );

    double rectRadius = radius / 4;

    /// 第一个
    _drawItem(
      canvas: canvas,
      offset: Offset(rectRadius, rectRadius),
      radius: rectRadius,
      color: colors[0],
    );

    /// 第二个
    _drawItem(
      canvas: canvas,
      offset: Offset(-rectRadius, rectRadius),
      radius: rectRadius,
      color: colors[1],
    );

    /// 第三个
    _drawItem(
      canvas: canvas,
      offset: Offset(-rectRadius, -rectRadius),
      radius: rectRadius,
      color: colors[2],
    );

    /// 第四个
    _drawItem(
      canvas: canvas,
      offset: Offset(rectRadius, -rectRadius),
      radius: rectRadius,
      color: colors[3],
    );
  }

  /// 绘制小正方形item
  void _drawItem({
    required Canvas canvas,
    required Offset offset,
    required double radius,
    Color color = Colors.blue,
  }) {
    Rect rect = Rect.fromCenter(
      center: offset,
      width: radius,
      height: radius,
    );
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    canvas.rotate(rotateTween.evaluate(animation));
    canvas.translate(-offset.dx, -offset.dy);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        rect,
        Radius.circular(5),
      ),
      _paint..color = color,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant RotateRectLoadPaint oldDelegate) =>
      oldDelegate.animation != animation;
}
