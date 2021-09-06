import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CircleHalo extends StatefulWidget {
  const CircleHalo({Key? key}) : super(key: key);

  @override
  _CircleHaloState createState() => _CircleHaloState();
}

class _CircleHaloState extends State<CircleHalo>
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
      painter: CircleHaloPainter(animation: _animationController),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class CircleHaloPainter extends CustomPainter {
  CircleHaloPainter({
    required this.animation,
  }) : super(repaint: animation);

  Animation<double> animation;

  final Animatable<double> breatheTween = TweenSequence<double>(
    <TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 4), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 4, end: 0), weight: 1),
    ],
  ).chain(
    CurveTween(curve: Curves.decelerate),
  );

  @override
  void paint(Canvas canvas, Size size) {
    /// 将画布的中心移到中心点
    canvas.translate(size.width / 2, size.height / 2);

    /// 默认画笔
    Paint _paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    /// 路径1
    final Path circlePath = Path()
      ..addOval(Rect.fromCenter(center: Offset.zero, width: 100, height: 100));

    /// 路径2
    final Path circlePath2 = Path()
      ..addOval(
          Rect.fromCenter(center: Offset(-1, 0), width: 100, height: 100));

    /// 联合路径
    Path result =
        Path.combine(PathOperation.difference, circlePath, circlePath2);

    /// 设置颜色
    List<Color> colors = [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];

    colors.addAll(colors.reversed.toList());

    final List<double> pos =
        List.generate(colors.length, (index) => index / colors.length);

    /// 设置shader
    _paint.shader =
        ui.Gradient.sweep(Offset.zero, colors, pos, TileMode.clamp, 0, 2 * pi);

    /// 设置遮罩滤镜
    _paint.maskFilter =
        MaskFilter.blur(BlurStyle.solid, breatheTween.evaluate(animation));

    canvas.drawPath(circlePath, _paint);

    canvas.save();
    canvas.rotate(animation.value * 2 * pi);
    _paint
      ..style = PaintingStyle.fill
      ..color = Color(0xff00abf2);
    _paint.shader = null;
    canvas.drawPath(result, _paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CircleHaloPainter oldDelegate) =>
      oldDelegate.animation != animation;
}
