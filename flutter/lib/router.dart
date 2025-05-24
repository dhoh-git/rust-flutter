import 'package:go_router/go_router.dart';
import 'package:score/view/animation.dart';
import 'package:score/view/painter.dart';
import 'package:score/view/search_bar/text_field_dropdown_page.dart';

import 'model/score.dart';
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
        return SecondPage(
          score: Score(idx:1,userIdx:2,roundIdx:3,clubIdx:4,scores:List<int>.filled(5, 6)),
        );
      },
    ),
    GoRoute(
      path: '/painter',
      builder: (context, state) {
        return PainterPage();
      },
    ),
    GoRoute(
      path: '/animation',
      builder: (context, state) {
        return PhysicsCardDragDemo();
      },
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) {
        return CustomTextFieldDropdownPage();
      },
    ),
  ],
);