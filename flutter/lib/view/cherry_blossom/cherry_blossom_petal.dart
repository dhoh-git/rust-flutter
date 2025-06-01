import 'dart:math';
import 'package:flutter/material.dart';

class CherryBlossomPetal {
  double x;
  double y;
  double size; // 벚꽃잎 크기 (반지름 대신 사용)
  double velocity;
  double drift;
  Color color;
  double opacity;
  double angle; // 회전 각도
  double rotationSpeed; // 회전 속도

  // 벚꽃잎 색상 팔레트
  static final List<Color> petalColors = [
    Colors.pink[100]!,
    Colors.pink[200]!,
    Colors.red[100]!,
    const Color(0xFFFFE0E0), // 연분홍
    const Color(0xFFFFF0F5), // 라벤더 블러쉬 (매우 연한 핑크)
  ];

  CherryBlossomPetal(Size screenSize)
      : x = Random().nextDouble() * screenSize.width,
        y = Random().nextDouble() * screenSize.height,
        size = Random().nextDouble() * 5 + 3, // 3.0 to 8.0
        velocity = Random().nextDouble() * 1.5 + 0.5, // 0.5 to 2.0 (좀 더 느리게)
        drift = Random().nextDouble() * 0.8 - 0.4, // -0.4 to 0.4 (좀 더 하늘하늘)
        color = petalColors[Random().nextInt(petalColors.length)],
        opacity = Random().nextDouble() * 0.4 + 0.6, // 0.6 to 1.0
        angle = Random().nextDouble() * 2 * pi, // 초기 각도 (0 to 2PI)
        rotationSpeed = Random().nextDouble() * 0.02 - 0.01; // -0.01 to 0.01 (회전 속도)

  void fall(Size screenSize) {
    y += velocity;
    x += drift;
    angle += rotationSpeed;

    // 화면 아래로 벗어나면 다시 위에서 시작
    if (y > screenSize.height + size * 2) { // size를 고려하여 여유를 줌
      y = -size * 2; // 화면 바로 위에서 시작
      x = Random().nextDouble() * screenSize.width;
      size = Random().nextDouble() * 5 + 3;
      velocity = Random().nextDouble() * 1.5 + 0.5;
      drift = Random().nextDouble() * 0.8 - 0.4;
      color = petalColors[Random().nextInt(petalColors.length)];
      opacity = Random().nextDouble() * 0.4 + 0.6;
      rotationSpeed = Random().nextDouble() * 0.02 - 0.01;
    }

    // 화면 좌우로 벗어나면 반대편에서 (선택적)
    if (x > screenSize.width + size * 2) {
      x = -size * 2;
    } else if (x < -size * 2) {
      x = screenSize.width + size * 2;
    }
  }

  // 간단한 벚꽃잎 모양 Path 생성
  Path getPetalPath() {
    Path path = Path();
    // 이 Path는 size를 반지름처럼 사용하며, (0,0)을 중심으로 그립니다.
    // 실제 그릴 때는 petal.x, petal.y로 이동(translate) 후 회전(rotate)합니다.
    path.moveTo(0, -size * 0.8); // 위쪽 뾰족한 부분 시작점
    path.quadraticBezierTo(size * 0.6, -size * 0.4, size * 0.8, 0); // 오른쪽 위 곡선
    path.quadraticBezierTo(size * 0.6, size * 0.4, 0, size * 0.8); // 오른쪽 아래 곡선 (가운데 아래로)
    path.quadraticBezierTo(-size * 0.6, size * 0.4, -size * 0.8, 0); // 왼쪽 아래 곡선
    path.quadraticBezierTo(-size * 0.6, -size * 0.4, 0, -size * 0.8); // 왼쪽 위 곡선 (시작점으로)
    path.close();
    return path;
  }
}