import 'package:flutter/material.dart';

class DecoratedBoxTransitions extends StatefulWidget {
  const DecoratedBoxTransitions({Key? key}) : super(key: key);

  @override
  _DecoratedBoxTransitionState createState() => _DecoratedBoxTransitionState();
}

class _DecoratedBoxTransitionState extends State<DecoratedBoxTransitions>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<Decoration> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = DecorationTween(
      begin: const BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 1),
              color: Colors.purple,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ]),
      end: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            color: Colors.purple,
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
    ).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _animationController.forward(),
      child: Container(
        width: 100,
        height: 100,
        child: DecoratedBoxTransition(
          position: DecorationPosition.background,
          decoration: _animation,
          child: Icon(
            Icons.camera_outlined,
            size: 80,
            color: Colors.white,
          ),
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
