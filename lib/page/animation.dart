import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/page_scaffold.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<StatefulWidget> createState() => _AnimationState();
}

class _AnimationState extends State<AnimationPage> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  var size = 100.0;
  var offset = const Offset(0.0, 0.0);
  var alignment = Alignment.topRight;
  var angle = 0.0;
  var count = 0;
  var color = Colors.pink;
  var borderRadius = 0.0;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    Animation<double> curve = CurvedAnimation(parent: controller, curve: Curves.ease);
    var sizeAnimation = Tween(begin: 100.0, end: 200.0).animate(curve);
    sizeAnimation.addListener(() {
      size = sizeAnimation.value;
      setState(() {});
    });

    var offsetAnimation = Tween(begin: const Offset(0.0, 0.0), end: const Offset(100.0, 100.0)).animate(curve);
    offsetAnimation.addListener(() {
      offset = offsetAnimation.value;
      setState(() {});
    });

    var alignAnimation = Tween(begin: Alignment.topRight, end: Alignment.bottomLeft).animate(curve);
    alignAnimation.addListener(() {
      alignment = alignAnimation.value;
      setState(() {});
    });

    var angleAnimation = Tween(begin: 0.0, end: 2 * math.pi).animate(curve);
    angleAnimation.addListener(() {
      angle = angleAnimation.value;
      setState(() {});
    });

    super.initState();
  }

  void play() {
    if (controller.status == AnimationStatus.completed) {
      controller.reverse(from: 1.0);
    } else {
      controller.forward(from: 0.0);
    }
    setState(() {
      count++;
      color = color == Colors.deepOrange? Colors.pink : Colors.deepOrange;
      borderRadius = borderRadius == 0? 40 : 0;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        title: "Animation",
        body: Column(children: [
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: play, child: const Text('play'))),
          Expanded(
              child: SizedBox(
                  width: double.infinity,
                  child: Stack(children: [
                    Center(
                        child: Transform.rotate(
                            angle: angle, child: Container(width: 50, height: 100, color: Colors.red))),
                    Positioned(
                        left: offset.dx,
                        top: offset.dy,
                        width: 50,
                        height: 50,
                        child: const ColoredBox(color: Colors.blue)),
                    Positioned(
                        bottom: 0, right: 0, width: size, height: size, child: const ColoredBox(color: Colors.yellow)),
                    Align(alignment: alignment, child: Container(width: 50, height: 50, color: Colors.green)),
                    Align(
                        alignment: Alignment.topCenter,
                        child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return SlideTransitionX(position: animation, direction: AxisDirection.down, child: child);
                            },
                            child: Text('$count', key: ValueKey(count), textScaleFactor: 5))),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius), color: color),
                        ))
                  ])))
        ]));
  }
}

class SlideTransitionX extends AnimatedWidget {
  SlideTransitionX({
    Key? key,
    required Animation<double> position,
    this.transformHitTests = true,
    this.direction = AxisDirection.down,
    required this.child,
  }) : super(key: key, listenable: position) {
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: const Offset(0, 1), end: const Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: const Offset(-1, 0), end: const Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: const Offset(0, -1), end: const Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: const Offset(1, 0), end: const Offset(0, 0));
        break;
    }
  }

  final bool transformHitTests;

  final Widget child;

  final AxisDirection direction;

  late final Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    final position = listenable as Animation<double>;
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
