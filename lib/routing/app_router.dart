import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_training_admin/config/utils/enum/router_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training_admin/features/navigation/view/bottom_navigation.dart';
//import 'package:riverpod_training_admin/features/navigation/view/side_navigation.dart';
import 'package:riverpod_training_admin/features/news/view/add_or_edit_news_page.dart';
import 'package:riverpod_training_admin/features/news/view/news_list_page.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AppRoute.news.path,
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          pageBuilder:
              (BuildContext context, GoRouterState state, Widget child) {
            return NoTransitionPage(
              key: state.pageKey,
              child: BottomNavigation(child: child),
            );
          },
          routes: <RouteBase>[
            GoRoute(
              name: AppRoute.news.name,
              path: AppRoute.news.path,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const NewsListPage(),
              ),
              routes: <RouteBase>[
                GoRoute(
                  name: AppRoute.addNews.name,
                  path: AppRoute.addNews.path,
                  pageBuilder: (context, state) => MaterialPage(
                    fullscreenDialog: true,
                    key: state.pageKey,
                    child: const AddOrEditNewsPage(),
                  ),
                ),
                GoRoute(
                  name: AppRoute.editNews.name,
                  path: AppRoute.editNews.path,
                  pageBuilder: (context, state) {
                    final newsId = state.queryParameters['newsId'] as String;
                    return MaterialPage(
                      fullscreenDialog: true,
                      key: state.pageKey,
                      child: AddOrEditNewsPage(newsId: newsId),
                    );
                  },
                ),
              ],
            ),
          ])
    ],
  );
}
