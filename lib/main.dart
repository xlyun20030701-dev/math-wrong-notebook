import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_wrong_notebook/src/app/theme/app_theme.dart';
import 'package:smart_wrong_notebook/src/mistake/screens/block_select_screen.dart';
import 'package:smart_wrong_notebook/src/mistake/screens/home_papers_screen.dart';
import 'package:smart_wrong_notebook/src/mistake/screens/notebook_screen.dart';
import 'package:smart_wrong_notebook/src/mistake/screens/paper_screen.dart';
import 'package:smart_wrong_notebook/src/mistake/screens/question_detail_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePapersScreen(),
      ),
      GoRoute(
        path: '/notebook',
        builder: (context, state) => const NotebookScreen(),
      ),
      GoRoute(
        path: '/papers/:paperId',
        builder: (context, state) => PaperScreen(
          paperId: int.parse(state.pathParameters['paperId']!),
        ),
      ),
      GoRoute(
        path: '/pages/:pageId/select',
        builder: (context, state) => BlockSelectScreen(
          pageId: int.parse(state.pathParameters['pageId']!),
          paperId: state.extra as int,
        ),
      ),
      GoRoute(
        path: '/question/:questionId',
        builder: (context, state) => QuestionDetailScreen(
          questionId: int.parse(state.pathParameters['questionId']!),
        ),
      ),
    ],
  );

  runApp(
    ProviderScope(
      child: MaterialApp.router(
        title: '错题整理',
        theme: buildLightTheme(),
        darkTheme: buildDarkTheme(),
        themeMode: ThemeMode.system,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
