import 'package:flutter/material.dart';
import 'snow_flake.dart'; // Snowflake 클래스 import
import 'snow_painter.dart'; // SnowPainter 클래스 import

class SnowScreen extends StatefulWidget {
  final int numberOfSnowflakes;

  const SnowScreen({Key? key, this.numberOfSnowflakes = 200}) : super(key: key);

  @override
  _SnowScreenState createState() => _SnowScreenState();
}

class _SnowScreenState extends State<SnowScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Snowflake> _snowflakes;
  Size? _screenSize; // 화면 크기를 저장할 변수

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // duration은 실제 애니메이션 속도에 큰 영향 없음 (반복 때문)
    )..repeat(); // 애니메이션을 계속 반복

    _controller.addListener(() {
      if (_screenSize != null) {
        // 화면 크기가 설정된 후에만 눈송이 업데이트
        setState(() {
          for (var flake in _snowflakes) {
            flake.fall(_screenSize!);
          }
        });
      }
    });

    // _snowflakes 초기화는 LayoutBuilder 또는 didChangeDependencies에서 수행하여
    // 정확한 화면 크기를 얻은 후에 하는 것이 좋습니다.
    // 여기서는 initState에서 임시로 비워두거나, 첫 프레임 이후에 초기화합니다.
    _snowflakes = [];
  }

  void _initializeSnowflakes(Size screenSize) {
    // 이전에 생성된 눈송이가 없다면 (또는 화면 크기가 변경되었다면) 새로 생성
    if (_snowflakes.isEmpty || _screenSize != screenSize) {
      _screenSize = screenSize;
      _snowflakes = List.generate(
        widget.numberOfSnowflakes,
            (index) => Snowflake(screenSize),
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
      backgroundColor: Colors.blueGrey[800], // 어두운 배경색
      body: LayoutBuilder(
        builder: (context, constraints) {
          // LayoutBuilder를 통해 현재 위젯이 차지할 수 있는 최대 크기를 얻음
          final screenSize = Size(constraints.maxWidth, constraints.maxHeight);
          // 화면 크기를 기반으로 눈송이 초기화 (필요한 경우)
          _initializeSnowflakes(screenSize);

          return CustomPaint(
            size: screenSize, // CustomPaint의 크기를 화면 전체로 설정
            painter: SnowPainter(
              snowflakes: _snowflakes,
              animation: _controller,
            ),
            child: Container(), // CustomPaint가 공간을 차지하도록
          );
        },
      ),
    );
  }
}