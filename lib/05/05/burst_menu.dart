import 'dart:math';

import 'package:flutter/material.dart';

class BurstMenu extends StatefulWidget {
  const BurstMenu({
    Key? key,
    required this.menus,
    required this.center,
  }) : super(key: key);

  final List<Widget> menus;

  final Widget center;

  @override
  _BurstMenuState createState() => _BurstMenuState();
}

class _BurstMenuState extends State<BurstMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _closed = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: _CircleFlowDelegate(
        // Tween(begin: 0.0, end: 90.0)
        //     .chain(CurveTween(curve: Interval(0, 0.2)))
        //     .animate(_animationController),
        _animationController,
        startAngle: 0,
        swapAngle: 90,
      ),
      children: [
        ...widget.menus,
        GestureDetector(
          onTap: () {
            if (_closed) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
            _closed = !_closed;
          },
          child: widget.center,
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _CircleFlowDelegate extends FlowDelegate {
  _CircleFlowDelegate(
    this.animation, {
    this.swapAngle = 180,
    this.startAngle = 0,
  }) : super(repaint: animation);

  /// 菜单圆弧的扫描角度
  final double? swapAngle;

  /// 菜单圆弧的起始角度
  final double? startAngle;

  final Animation<double> animation;

  @override
  void paintChildren(FlowPaintingContext context) {
    double radius = context.size.shortestSide / 2;

    final int count = context.childCount - 1;

    final double perRad = swapAngle! / 180 * pi / (count - 1);

    /// 将角度转化为弧度
    double rotate = startAngle! / 180 * pi;

    for (int i = 0; i < count; i++) {
      final double cSizeX = context.getChildSize(i)!.width / 2;
      final double cSizeY = context.getChildSize(i)!.height / 2;
      // final double offsetX =
      //     animation.value * (radius - cSizeX) * cos(i * perRad + rotate) +
      //         radius;
      // final double offsetY =
      //     animation.value * (radius - cSizeY) * sin(i * perRad + rotate) +
      //         radius;

      // context.paintChild(
      //   i,
      //   transform: Matrix4.translationValues(
      //     offsetX - cSizeX,
      //     offsetY - cSizeY,
      //     0,
      //   ),
      // );

      final double offsetX =
          animation.value * (radius - cSizeX) * cos(i * perRad + rotate);
      final double offsetY =
          animation.value * (radius - cSizeY) * sin(i * perRad + rotate);

      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          offsetX,
          offsetY,
          0,
        ),
      );
    }

    // context.paintChild(
    //   context.childCount - 1,
    //   transform: Matrix4.translationValues(
    //     radius - context.getChildSize(context.childCount - 1)!.width / 2,
    //     radius - context.getChildSize(context.childCount - 1)!.height / 2,
    //     0,
    //   ),
    // );
    context.paintChild(
      context.childCount - 1,
      transform: Matrix4.translationValues(
        0,
        0,
        0,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant _CircleFlowDelegate oldDelegate) =>
      oldDelegate.startAngle != startAngle ||
      oldDelegate.swapAngle != swapAngle;
}
