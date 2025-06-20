import 'package:flutter/material.dart';
import 'package:score/view/cherry_blossom/cherry_blossom.dart'; // deferred as cherry_blossom;
import 'package:score/view/cherry_blossom/cherry_blossom_loader.dart';
import 'package:score/view/overlay/easy_overlay.dart';
import 'package:score/view/painter.dart';
import 'package:score/view/search_bar/text_field_dropdown_page.dart';
import 'package:sidebarx/sidebarx.dart';

void main() {
  runApp(NavHome());
}

class NavHome extends StatelessWidget {
  NavHome({Key? key}) : super(key: key);

  // 내가 어느 메뉴를 클릭했고, 현재 사이드바가 펼쳐져있는지 여부를 관리하는 컨트롤러
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SidebarX Example',
      //debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // 뭐가바뀌는지 모르겠음
        primaryColor: primaryColor,
        // 사이드바 배경 컬러
        canvasColor: canvasColor,
        // 우측 화면 배경컬러
        scaffoldBackgroundColor: scaffoldBackgroundColor,

        // 우측 화면에 있는 텍스트 스타일
        // 타이틀에 대한 텍스트 스타일인거같음.
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: Colors.white,
            fontSize: 46,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      home: Builder(
        builder: (context) {
          // 기기가 일반 스마트폰인지 태블릿인지 여부
          final isSmallScreen = MediaQuery.of(context).size.width < 600;
          return Scaffold(
            key: _key,
            // 기기가 일반 스마트폰인지 태블릿인지 여부에 따라 앱바 다르게 보이게 함
            appBar: isSmallScreen
                ? AppBar(
                    backgroundColor: canvasColor,
                    title: Text(_getTitleByIndex(_controller.selectedIndex)),
                    leading: IconButton(
                      onPressed: () {
                        // if (!Platform.isAndroid && !Platform.isIOS) {
                        //   _controller.setExtended(true);
                        // }
                        _key.currentState?.openDrawer();
                      },
                      icon: const Icon(Icons.menu),
                    ),
                  )
                // 태블릿일 경우 아래 null 부분 실행
                : null,
            drawer: ExampleSidebarX(controller: _controller),
            body: Row(
              children: [
                // 일반 스마트폰의 경우 사이드바가 아님.
                if (!isSmallScreen) ExampleSidebarX(controller: _controller),
                // 우측의 화면
                Expanded(
                  child: Center(
                    child: _ScreensExample(
                      controller: _controller,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        //debugPrint('Red: ${event.position}');
        if (!_controller.extended) {
          _controller.setExtended(true);
        }
      },
      onExit: (event) {
        if (_controller.extended) {
          _controller.setExtended(false);
        }
      },
      child: SidebarX(
        controller: _controller,
        theme: SidebarXTheme(
          //margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: canvasColor,
            //borderRadius: BorderRadius.circular(20),
          ),
          hoverColor: scaffoldBackgroundColor,
          textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          selectedTextStyle: const TextStyle(color: Colors.white),
          itemTextPadding: const EdgeInsets.only(left: 30),
          selectedItemTextPadding: const EdgeInsets.only(left: 30),
          itemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: canvasColor),
          ),
          selectedItemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: actionColor.withOpacity(0.37),
            ),
            gradient: const LinearGradient(
              colors: [accentCanvasColor, canvasColor],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.28),
                blurRadius: 30,
              )
            ],
          ),
          iconTheme: IconThemeData(
            color: Colors.white.withOpacity(0.7),
            size: 20,
          ),
          selectedIconTheme: const IconThemeData(
            color: Colors.white,
            size: 20,
          ),
        ),

        extendedTheme: const SidebarXTheme(
          width: 200,
          decoration: BoxDecoration(
            color: canvasColor,
          ),
        ),
        // 사이드바 하단에 divider, 아래에 열고닫는 버튼이 있음
        footerDivider: divider,
        // 사이드바의 젤 상단에 나오는 텍스트
        headerBuilder: (context, extended) {
          return const SizedBox(
            height: 100,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("메뉴"),
            ),
          );
        },

        //사이드바의 메뉴 설정.
        // label이 메뉴의 이름을 나타냄
        items: [
          SidebarXItem(
            icon: Icons.home,
            label: 'Home',
            onTap: () {
              debugPrint('Home');
            },
          ),
          const SidebarXItem(
            icon: Icons.search,
            label: 'Search',
          ),
          const SidebarXItem(
            icon: Icons.people,
            label: 'People',
          ),
          const SidebarXItem(
            icon: Icons.favorite,
            label: 'Favorites',
          ),
          const SidebarXItem(
            icon: Icons.window,
            label: 'Overlay',
          ),
          const SidebarXItem(
            iconWidget: FlutterLogo(size: 20),
            label: 'Flutter',
          ),
        ],
      ),
    );
  }
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pageTitle = _getTitleByIndex(controller.selectedIndex);
        switch (controller.selectedIndex) {
          // 여기서 사이드바에서 메뉴를 클릭했을 때 달라지는 우측의 화면 지정해주는 곳.
          // ex) case 1일땐 어느화면 보여주고, case 2 일땐 어느 화면 보여주고..
          case 0:
            return ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemBuilder: (context, index) => Container(
                height: 100,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).canvasColor,
                  boxShadow: const [BoxShadow()],
                ),
              ),
            );
          case 1:
            return CustomTextFieldDropdownPage(key: key);
          case 2:
            return PainterPage(
              key: key,
            );
          case 3:
            //await cherry_blossom.loadLibrary();
            return const CherryBlossomLoader();
          //return CherryBlossomScreen(numberOfPetals: 50);
          /*return DraggableCard(
                child:
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: MediaQuery.of(context).size.width/10,)
            );*/
          case 4:
            return EasyOverlay(
              key: key,
              title: "overlay",
            );

          default:
            return Text(
              pageTitle,
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }
}

// 새로운 화면을 추가하거나 제거할 때 아래 index를 통해 설정하고 사용
String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Home';
    case 1:
      return 'Search';
    case 2:
      return 'People';
    case 3:
      return 'Favorites';
    case 4:
      return 'Overlay';
    case 5:
      return 'Custom iconWidget';
    case 6:
      return 'Profile';
    case 7:
      return 'Settings';
    default:
      return 'Not found page';
  }
}

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
