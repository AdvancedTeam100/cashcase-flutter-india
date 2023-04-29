import 'package:cashfuse/utils/images.dart';
import 'package:flutter/material.dart';

class ImageRotate extends StatefulWidget {
  @override
  _ImageRotateState createState() => new _ImageRotateState();
}

class _ImageRotateState extends State<ImageRotate> with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 2),
      reverseDuration: Duration.zero,
    );

    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      animation: animationController,
      child: new Image.asset(
        Images.refer,
        height: 50,
      ),
      builder: (BuildContext context, Widget _widget) {
        return new Transform.rotate(
          angle: animationController.value * 6.3,
          child: _widget,
        );
      },
    );
  }
}
