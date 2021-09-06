import 'dart:math';

import 'package:flutter/material.dart';

class ToggleRotate extends StatefulWidget {
  const ToggleRotate({
    Key? key,
    required this.child,
    this.onEnd,
    this.onTap,
    this.beginAngle = 0,
    this.endAngle = 90,
    this.durationMs = 200,
    this.clockwise = true,
    this.curve = Curves.fastOutSlowIn,
  }) : super(key: key);

  /// 子组件
  final Widget child;

  /// 动画结束回调
  final ValueChanged<bool>? onEnd;

  /// 点击事件
  final VoidCallback? onTap;

  /// 起始角度
  final double beginAngle;

  /// 终止角度
  final double endAngle;

  /// 动画时长
  final int durationMs;

  /// 是否顺时针旋转
  final bool clockwise;

  /// 动画曲线
  final Curve curve;

  @override
  _ToggleRotateState createState() => _ToggleRotateState();
}

class _ToggleRotateState extends State<ToggleRotate>
    with SingleTickerProviderStateMixin {
  /// 是否已经开启动画
  bool _rotated = false;

  late AnimationController _animationController;

  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.durationMs,
      ),
    );

    _initTweenAnim();
  }

  @override
  void didUpdateWidget(ToggleRotate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.durationMs != oldWidget.durationMs) {
      _animationController.dispose();
      _animationController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: widget.durationMs,
        ),
      );
    }

    if (widget.beginAngle != oldWidget.beginAngle ||
        widget.endAngle != oldWidget.endAngle ||
        widget.durationMs != oldWidget.durationMs ||
        widget.curve != oldWidget.curve) {
      _initTweenAnim();
    }
  }

  /// 初始化曲线动画
  void _initTweenAnim() {
    _animation = Tween<double>(
      begin: widget.beginAngle / 180 * pi,
      end: widget.endAngle / 180 * pi,
    ).chain(CurveTween(curve: widget.curve)).animate(_animationController);
  }

  /// 处理点击事件
  void _toggleRotate() async {
    widget.onTap?.call();
    if (_rotated) {
      await _animationController.reverse();
    } else {
      await _animationController.forward();
    }
    _rotated = !_rotated;
    widget.onEnd?.call(_rotated);
  }

  double get rad => widget.clockwise ? _animation.value : -_animation.value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _toggleRotate,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) => Transform(
          transform: Matrix4.rotationZ(rad),
          alignment: Alignment.center,
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
