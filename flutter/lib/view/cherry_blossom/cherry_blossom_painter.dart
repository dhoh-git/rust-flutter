import 'package:flutter/material.dart';
import 'cherry_blossom_petal.dart'; // CherryBlossomPetal 클래스 import

class CherryBlossomPainter extends CustomPainter {
  final List<CherryBlossomPetal> petals;
  final Animation<double> animation;

  CherryBlossomPainter({required this.petals, required this.animation})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var petal in petals) {
      paint.color = petal.color.withOpacity(petal.opacity);

      canvas.save(); // 현재 변환 상태 저장
      // 벚꽃잎의 중심으로 이동
      canvas.translate(petal.x, petal.y);
      // 벚꽃잎 회전
      canvas.rotate(petal.angle);
      // 벚꽃잎 그리기 (getPetalPath는 (0,0)을 중심으로 그려짐)
      canvas.drawPath(petal.getPetalPath(), paint);
      canvas.restore(); // 이전 변환 상태 복원
    }
  }

  @override
  bool shouldRepaint(covariant CherryBlossomPainter oldDelegate) {
    return true; // 항상 다시 그림 (애니메이션 때문)
  }
}