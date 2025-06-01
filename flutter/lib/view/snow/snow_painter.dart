import 'package:flutter/material.dart';
import 'snow_flake.dart'; // Snowflake 클래스 import

class SnowPainter extends CustomPainter {
  final List<Snowflake> snowflakes;
  final Animation<double> animation; // 애니메이션 값

  SnowPainter({required this.snowflakes, required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var flake in snowflakes) {
      paint.color = flake.color.withOpacity(flake.opacity);
      canvas.drawCircle(Offset(flake.x, flake.y), flake.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant SnowPainter oldDelegate) {
    // 애니메이션이 변경될 때마다 다시 그리도록 true 반환
    // 또는 snowflakes 리스트가 변경되었는지 비교할 수도 있습니다.
    return true;
  }
}