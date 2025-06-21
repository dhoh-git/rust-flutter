import 'package:flutter/material.dart';
import 'cherry_blossom_petal.dart';
import 'cherry_blossom_painter.dart';

class CherryBlossomScreen extends StatefulWidget {
  final int numberOfPetals;

  const CherryBlossomScreen({Key? key, this.numberOfPetals = 150})
      : super(key: key);

  @override
  _CherryBlossomScreenState createState() => _CherryBlossomScreenState();
}

class _CherryBlossomScreenState extends State<CherryBlossomScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<CherryBlossomPetal> _petals;
  Size? _screenSize;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // 실제 애니메이션 속도에 큰 영향 없음
    )..repeat();

    _controller.addListener(() {
      if (_screenSize != null && mounted) {
        // mounted 체크 추가
        setState(() {
          for (var petal in _petals) {
            petal.fall(_screenSize!);
          }
        });
      }
    });
    _petals = []; // LayoutBuilder에서 초기화
  }

  void _initializePetals(Size screenSize) {
    if (_petals.isEmpty || _screenSize != screenSize) {
      _screenSize = screenSize;
      _petals = List.generate(
        widget.numberOfPetals,
        (index) => CherryBlossomPetal(screenSize),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 벚꽃과 어울리는 배경색 (예: 하늘색 또는 연한 녹색)
      backgroundColor: Colors.lightBlue[100],
      // appBar: AppBar(title: Text("벚꽃 애니메이션")), // 필요하다면 AppBar 추가
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenSize = Size(constraints.maxWidth, constraints.maxHeight);
          _initializePetals(screenSize);

          return CustomPaint(
            size: screenSize,
            painter: CherryBlossomPainter(
              petals: _petals,
              animation: _controller,
            ),
            child: Container(),
          );
        },
      ),
    );
  }
}
