import 'package:flutter/material.dart';

class RotatingChild extends StatefulWidget {
  const RotatingChild({
    super.key,
    required this.child,
    this.seconds = 10,
    this.velocity = 1,
  });

  final Widget child;
  final int seconds;
  final double velocity;

  @override
  _RotatingChildState createState() => _RotatingChildState();
}

class _RotatingChildState extends State<RotatingChild> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: widget.seconds),
      vsync: this,
      upperBound: widget.velocity,
    );
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween<double>(begin: 0.0, end: widget.seconds.toDouble()).animate(_controller),
      child: widget.child,
    );
  }
}
