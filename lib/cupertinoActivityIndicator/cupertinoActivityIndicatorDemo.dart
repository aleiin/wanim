import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoActivityIndicatorDemo extends StatefulWidget {
  const CupertinoActivityIndicatorDemo({Key? key}) : super(key: key);

  @override
  _CupertinoActivityIndicatorDemoState createState() =>
      _CupertinoActivityIndicatorDemoState();
}

class _CupertinoActivityIndicatorDemoState
    extends State<CupertinoActivityIndicatorDemo>
    with SingleTickerProviderStateMixin {
  bool _animating = true;

  void onChanged(bool value) {
    setState(() {
      _animating = !_animating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Switch(
          value: _animating,
          onChanged: onChanged,
        ),
        CupertinoActivityIndicator(
          animating: _animating,
          radius: 20,
        ),
      ],
    );
  }
}
