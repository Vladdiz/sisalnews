import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/listItemPages/news_detail_page.dart';
import '../pages/navigationBar/bottom_bar_page.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const BottomBarPage();
      },
      routes: <RouteBase>[
        GoRoute(
          name: "newsDetail",
          path: "/newsDetail/:link",
          builder: (BuildContext context, GoRouterState state) {
            return NewsDetailPage(link: state.pathParameters['link'] ?? "");
          },
        ),
      ],
    ),
  ],
);
