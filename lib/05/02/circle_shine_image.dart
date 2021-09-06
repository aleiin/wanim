import 'package:flutter/material.dart';

class CircleShineImage extends StatefulWidget {
  const CircleShineImage({
    Key? key,
    this.maxBlurRadius = 10,
    this.color = Colors.purple,
    this.duration = const Duration(seconds: 2),
    this.curve = Curves.ease,
    required this.image,
    this.radius = 30,
  }) : super(key: key);

  /// 阴影最大值
  final double maxBlurRadius;

  /// 阴影颜色
  final Color color;

  /// 动画器时长
  final Duration duration;

  /// 动画器曲线
  final Curve curve;

  /// 图片
  final ImageProvider image;

  /// 圆半径
  final double radius;

  @override
  _CircleShineImageState createState() => _CircleShineImageState();
}

class _CircleShineImageState extends State<CircleShineImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addListener(() {
        setState(() {});
      });

    _animation = Tween<double>(begin: 0, end: widget.maxBlurRadius)
        .animate(_animationController);

    _animationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.radius * 5,
      height: widget.radius * 5,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: widget.image,
            fit: BoxFit.fill,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: widget.color,
              blurRadius: _animation.value,
              spreadRadius: 0,
            )
          ]),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
