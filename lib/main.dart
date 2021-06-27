import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'back.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> _animation;
  late Animation<double> circleAnimation;
  late Animation yelloDot;
  late Animation redDot;
  late Animation purpleDot;
  late Animation blueDot;

  var cur = Curves.linear;

  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));

    _animation = Tween<double>(begin: 0.0, end: 20.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.3, 0.7, curve: Curves.fastOutSlowIn)));

    circleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController, curve: Curves.fastOutSlowIn));

    yelloDot = TweenSequence([
      TweenSequenceItem<AlignmentGeometry?>(
          tween: AlignmentGeometryTween(
              begin: Alignment.centerLeft, end: Alignment.center),
          weight: 2),
      TweenSequenceItem<AlignmentGeometry?>(
          tween: AlignmentGeometryTween(
              begin: Alignment.center, end: Alignment.center),
          weight: 1),
      TweenSequenceItem<AlignmentGeometry?>(
          tween: AlignmentGeometryTween(
              begin: Alignment.center, end: Alignment.centerRight),
          weight: 2),
    ]).animate(CurvedAnimation(parent: animationController, curve: cur));

    redDot = TweenSequence([
      TweenSequenceItem<AlignmentGeometry?>(
          tween: AlignmentGeometryTween(
              begin: Alignment.centerRight, end: Alignment.center),
          weight: 2),
      TweenSequenceItem<AlignmentGeometry?>(
          tween: AlignmentGeometryTween(
              begin: Alignment.center, end: Alignment.center),
          weight: 1),
      TweenSequenceItem<AlignmentGeometry?>(
          tween: AlignmentGeometryTween(
              begin: Alignment.center, end: Alignment.centerLeft),
          weight: 2),
    ]).animate(CurvedAnimation(parent: animationController, curve: cur));

    purpleDot = TweenSequence([
      TweenSequenceItem<AlignmentGeometry?>(
          tween: AlignmentGeometryTween(
              begin: Alignment.topCenter, end: Alignment.center),
          weight: 2),
      TweenSequenceItem<AlignmentGeometry?>(
          tween: AlignmentGeometryTween(
              begin: Alignment.center, end: Alignment.center),
          weight: 1),
      TweenSequenceItem<AlignmentGeometry?>(
          tween: AlignmentGeometryTween(
              begin: Alignment.center, end: Alignment.bottomCenter),
          weight: 2),
    ]).animate(CurvedAnimation(parent: animationController, curve: cur));

    blueDot = TweenSequence([
      TweenSequenceItem<AlignmentGeometry?>(
          tween: AlignmentGeometryTween(
              begin: Alignment.bottomCenter, end: Alignment.center),
          weight: 2),
      TweenSequenceItem<AlignmentGeometry?>(
          tween: AlignmentGeometryTween(
              begin: Alignment.center, end: Alignment.center),
          weight: 1),
      TweenSequenceItem<AlignmentGeometry?>(
          tween: AlignmentGeometryTween(
              begin: Alignment.center, end: Alignment.topCenter),
          weight: 2),
    ]).animate(CurvedAnimation(parent: animationController, curve: cur));

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });

    animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundAnimationWidget(
            animation: _animation,
            backgroundAnimationController: animationController,
            isComplete: false,
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: Container(
                height: 200,
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) => Transform.rotate(
                        angle: circleAnimation.value * 2 * pi,
                        child: Container(
                          height: 200,
                          width: 200,
                          child: Container(
                              height: 200,
                              width: 200,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: yelloDot.value,
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(255, 181, 0, 1),
                                          shape: BoxShape.circle),
                                    ),
                                  ),
                                  Align(
                                    alignment: redDot.value,
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(255, 0, 103, 1),
                                          shape: BoxShape.circle),
                                    ),
                                  ),
                                  Align(
                                    alignment: purpleDot.value,
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(0, 222, 255, 1),
                                          shape: BoxShape.circle),
                                    ),
                                  ),
                                  Align(
                                    alignment: blueDot.value,
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(218, 0, 255, 1),
                                          shape: BoxShape.circle),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 200),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "@_thelazyone_",
                style: TextStyle(color: Colors.grey.shade700, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
