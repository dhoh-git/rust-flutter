import 'package:go_router/go_router.dart';
import 'package:score/view/second_page.dart';

import 'main.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return MyHomePage(title: 'Gorouter app',);
      },
    ),
    GoRoute(
      path: '/second',
      builder: (context, state) {
        return SecondPage();
      },
    ),
  ],
);