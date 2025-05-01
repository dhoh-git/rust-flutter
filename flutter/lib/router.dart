import 'package:go_router/go_router.dart';

import 'view/second_page.dart';
import 'package:score/view/main_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return MainPage(title: 'Gorouter app',);
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