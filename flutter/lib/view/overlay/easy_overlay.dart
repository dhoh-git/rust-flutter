import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'overlay_example.dart';

class EasyOverlay extends StatelessWidget {
  EasyOverlay({Key? key, required this.title}) : super(key: key);

  final String title;

  final OverlayExample _example = OverlayExample();

  @override
  Widget build(BuildContext context) {
    _example.context = context;
    return Scaffold(
        //appBar: AppBar(title: Text(title)),
        body: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: _example.showAlert, child: Text('Show alert')),
                  ElevatedButton(onPressed: _example.toast, child: Text('Toast'))
                ])));
  }
}