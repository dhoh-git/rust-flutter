import 'package:flutter/material.dart';
//import 'package:go_router/go_router.dart';
//import 'package:score/model/user.dart';
import 'package:score/router.dart';
import 'package:sidebarx/sidebarx.dart';
//import 'package:score/view/second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final controller = SidebarXController(selectedIndex: 0, extended: true);
    final key = GlobalKey<ScaffoldState>();

    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        fontFamily: 'NotoSansKR',
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
