import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:weather/background_painter.dart';

class BackgroundWidget extends StatefulWidget {

  final double headerHeight;

  const BackgroundWidget(this.headerHeight, {Key key}) : super(key: key);

  _BackgroundWidgetState createState() => new _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  Animation<Offset> animationStarOffset;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 10000), vsync: this);
    animation = new Tween(begin: 0.0, end: 345.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    var beginOffset = new Offset(290.0, 0.0);
    var endOffset = _getEndOffset(beginOffset);
    animationStarOffset = new Tween<Offset>(begin: beginOffset, end: endOffset)
        .animate(controller);
    controller.forward();
  }

  Widget build(BuildContext context) {
    return Stack(
      alignment: new Alignment(0.5, 0.94),
      children: <Widget>[
        new CustomPaint(
          painter:
              new BackgroundPainter(animation.value, animationStarOffset.value),
          child: new Container(height: widget.headerHeight),
        ),
        new Image.asset(
          'assets/reindeer.png',
          scale: 15.0,
        ),
      ],
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  _getEndOffset(Offset beginOffset) {
    var radians = 30.0 * pi / 180;
    var dy = 345.0;
    var dx = beginOffset.dx - dy * cos(radians) / sin(radians);
    return new Offset(dx, dy);
  }
}
