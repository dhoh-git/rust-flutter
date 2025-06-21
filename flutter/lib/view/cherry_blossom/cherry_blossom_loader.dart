import 'package:flutter/material.dart';
// 'deferred as' 키워드를 사용하여 라이브러리를 지연 로딩합니다.
import 'cherry_blossom.dart' deferred as cherry_blossom;

/// [cherry_blossom.CherryBlossomScreen] 라이브러리를 지연 로딩하고
/// 준비될 때까지 로딩 인디케이터를 표시하는 위젯입니다.
class CherryBlossomLoader extends StatefulWidget {
  const CherryBlossomLoader({Key? key}) : super(key: key);

  @override
  State<CherryBlossomLoader> createState() => _CherryBlossomLoaderState();
}

class _CherryBlossomLoaderState extends State<CherryBlossomLoader> {
  // 라이브러리가 로드되면 완료되는 Future입니다.
  late Future<void> _loadLibraryFuture;

  @override
  void initState() {
    super.initState();
    // 라이브러리 로딩을 시작합니다.
    _loadLibraryFuture = cherry_blossom.loadLibrary().then((_) {
      // 10초 지연
      return Future.delayed(const Duration(seconds: 3));
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _loadLibraryFuture,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        // Future가 완료되면, 에러를 확인하고 실제 스크린을 빌드합니다.
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // 로딩에 실패하면 에러 메시지를 표시합니다.
            return Scaffold(
              body: Center(
                child: Text('라이브러리 로딩 오류: ${snapshot.error}'),
              ),
            );
          }
          // 로드가 완료되면, 지연된 라이브러리의 스크린을 생성하여 반환합니다.
          return cherry_blossom.CherryBlossomScreen();
        }

        // 라이브러리가 로딩되는 동안에는 플레이스홀더를 보여줍니다.
        return Scaffold(
          backgroundColor: Colors.lightBlue[100], // 기존 스크린과 배경색을 맞춥니다.
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
