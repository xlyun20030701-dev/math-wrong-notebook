import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:smart_wrong_notebook/src/app/theme/app_theme.dart';
import 'package:smart_wrong_notebook/src/mistake/backup/backup_service.dart';
import 'package:smart_wrong_notebook/src/mistake/screens/block_select_screen.dart';
import 'package:smart_wrong_notebook/src/mistake/screens/clean_block_screen.dart';
import 'package:smart_wrong_notebook/src/mistake/screens/home_papers_screen.dart';
import 'package:smart_wrong_notebook/src/mistake/screens/notebook_screen.dart';
import 'package:smart_wrong_notebook/src/mistake/screens/paper_screen.dart';
import 'package:smart_wrong_notebook/src/mistake/screens/print_list_screen.dart';
import 'package:smart_wrong_notebook/src/mistake/screens/question_detail_screen.dart';
import 'package:smart_wrong_notebook/src/mistake/screens/settings_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _applyPendingRestoreIfAny();

  final router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            _Shell(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(path: '/', builder: (_, __) => const HomePapersScreen()),
          ]),
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
                path: '/notebook',
                builder: (_, __) => const NotebookScreen()),
          ]),
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(path: '/print', builder: (_, __) => const PrintListScreen()),
          ]),
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
                path: '/settings',
                builder: (_, __) => const SettingsScreen()),
          ]),
        ],
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
      GoRoute(
        path: '/clean/:blockId',
        builder: (context, state) => CleanBlockScreen(
          blockId: int.parse(state.pathParameters['blockId']!),
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

Future<void> _applyPendingRestoreIfAny() async {
  try {
    final docs = await getApplicationDocumentsDirectory();
    final svc = BackupService(
      dataRoot: p.join(docs.path, 'math_wrong_notebook'),
      dbFilePath: p.join(docs.path, 'math_wrong_notebook.db'),
    );
    await svc.applyPendingRestore();
  } catch (_) {
    // 恢复失败不阻塞启动。
  }
}

class _Shell extends StatelessWidget {
  const _Shell({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (int index) =>
            navigationShell.goBranch(index),
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(CupertinoIcons.doc_plaintext),
            label: '试卷',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.book),
            label: '错题',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.printer),
            label: '打印',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.gear),
            label: '设置',
          ),
        ],
      ),
    );
  }
}
