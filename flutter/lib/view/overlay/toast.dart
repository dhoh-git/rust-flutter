import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Toast extends StatefulWidget {
  const Toast({Key? key}) : super(key: key);

  @override
  _ToastState createState() => _ToastState();
}

class _ToastState extends State<Toast> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.decelerate));

    _controller.forward().whenComplete(() {
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 70),
          child: FadeTransition(
            opacity: _animation,
            child: Material(
              child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey),
                  child: Text('Toast', style: TextStyle(color: Colors.white))),
            ),
          ),
        ),
      ),
    );
  }
}