import 'dart:math';
import 'package:flutter/material.dart';

class Snowflake {
  double x;
  double y;
  double radius;
  double velocity;
  double drift; // 좌우 흔들림
  Color color;
  double opacity;

  Snowflake(Size screenSize)
      : x = Random().nextDouble() * screenSize.width,
        y = Random().nextDouble() * screenSize.height, // 처음에는 화면 전체에 흩뿌려지도록
        radius = Random().nextDouble() * 3 + 2, // 2.0 to 5.0
        velocity = Random().nextDouble() * 2 + 0, // 1.0 to 3.0
        drift = Random().nextDouble() * 0.5 - 0.25, // -0.25 to 0.25
        color = Colors.white,
        opacity = Random().nextDouble() * 0.5 + 0.5; // 0.5 to 1.0

  void fall(Size screenSize) {
    y += velocity;
    x += drift;

    // 화면 아래로 벗어나면 다시 위에서 시작
    if (y > screenSize.height) {
      y = -radius; // 화면 바로 위에서 시작하도록
      x = Random().nextDouble() * screenSize.width;
      radius = Random().nextDouble() * 3 + 2;
      velocity = Random().nextDouble() * 2 + 1;
      drift = Random().nextDouble() * 0.5 - 0.25;
      opacity = Random().nextDouble() * 0.5 + 0.5;
    }

    // 화면 좌우로 벗어나면 반대편에서 나타나도록 (선택적)
    if (x > screenSize.width + radius) {
      x = -radius;
    } else if (x < -radius) {
      x = screenSize.width + radius;
    }
  }
}