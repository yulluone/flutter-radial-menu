import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' show radians;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(body: SizedBox.expand(child: RadialMenu())));
  }
}

class RadialMenu extends StatefulWidget {
  const RadialMenu({Key? key}) : super(key: key);
  @override
  createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 900), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimation(controller: controller);
  }
}

class RadialAnimation extends StatelessWidget {
  RadialAnimation({required this.controller, Key? key})
      : scale = Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(
            CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn)),
        transform = Tween<double>(
          begin: 0.0,
          end: 100.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.linearToEaseOut),
        ),
        rotation = Tween<double>(
          begin: 0.0,
          end: 360.0,
        ).animate(
          CurvedAnimation(
              parent: controller,
              curve: const Interval(0.0, 0.75, curve: Curves.decelerate)),
        ),
        super(key: key);

  //animations
  final AnimationController controller;
  final Animation<double> scale;
  final Animation<double> transform;
  final Animation<double> rotation;

  @override
  build(context) {
    return Container(
        color: Colors.grey.shade800,
        child: Center(
            child: AnimatedBuilder(
                animation: controller,
                builder: (context, builder) {
                  return Transform.rotate(
                      angle: radians(rotation.value),
                      child: Stack(
                        children: [
                          _buildButton(0,
                              color: Colors.blue,
                              icon: FontAwesomeIcons.facebook),
                          _buildButton(45,
                              color: Colors.green[900],
                              icon: FontAwesomeIcons.google),
                          _buildButton(90,
                              color: Colors.green,
                              icon: FontAwesomeIcons.whatsapp),
                          _buildButton(135,
                              color: Colors.pinkAccent[400],
                              icon: FontAwesomeIcons.instagram),
                          _buildButton(180,
                              color: Colors.blue,
                              icon: FontAwesomeIcons.twitter),
                          _buildButton(225,
                              color: Colors.blue[900],
                              icon: FontAwesomeIcons.linkedin),
                          _buildButton(270,
                              color: Colors.redAccent[700],
                              icon: FontAwesomeIcons.youtube),
                          _buildButton(315,
                              color: Colors.teal,
                              icon: FontAwesomeIcons.reddit),
                          Transform.scale(
                              scale: scale.value - 1,
                              child: FloatingActionButton(
                                  backgroundColor: Colors.red,
                                  onPressed: _close,
                                  hoverColor: Colors.red[400],
                                  child: const FaIcon(
                                      FontAwesomeIcons.circleXmark))),
                          Transform.scale(
                              scale: scale.value,
                              child: FloatingActionButton(
                                  onPressed: _open,
                                  hoverColor: Colors.lightBlue,
                                  child: const FaIcon(
                                      FontAwesomeIcons.solidCircleDot)))
                        ],
                      ));
                })));
  }

  _buildButton(double angle, {Color? color, IconData? icon}) {
    final double rad = radians(angle);
    return Transform(
        transform: Matrix4.identity()
          ..translate(
              (transform.value) * cos(rad), (transform.value) * sin(rad)),
        child: FloatingActionButton(
            backgroundColor: color,
            onPressed: _close,
            hoverColor: Colors.grey,
            child: FaIcon(icon)));
  }

  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }
}
