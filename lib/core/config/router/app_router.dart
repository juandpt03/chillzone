import 'package:chillzone/features/home/presentation/screens/screens.dart';
import 'package:chillzone/features/home/presentation/screens/views/work_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _sectionANavigatorKey = GlobalKey<NavigatorState>();
final appRouter = GoRouter(
  initialLocation: SleepTrackerView.routeName,
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      pageBuilder: (context, state, navigationShell) => MaterialPage(
        child: HomeScreen(navigationShell: navigationShell),
        key: state.pageKey,
      ),
      branches: [
        StatefulShellBranch(
          navigatorKey: _sectionANavigatorKey,
          routes: [
            GoRoute(
              path: SleepTrackerView.routeName,
              builder: (context, state) => const SleepTrackerView(),
              name: SleepTrackerView.routeName,
            )
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: SleepView.route,
              builder: (context, state) => const SleepView(),
              name: SleepView.route,
            )
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: WorkView.routeName,
              builder: (context, state) => const WorkView(),
              name: WorkView.routeName,
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: StudyView.routeName,
              builder: (context, state) => const StudyView(),
              name: StudyView.routeName,
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: CookView.routeName,
              builder: (context, state) => const CookView(),
              name: CookView.routeName,
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: ExerciseView.routeName,
              builder: (context, state) => const ExerciseView(),
              name: ExerciseView.routeName,
            )
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: MusicView.routeName,
              builder: (context, state) => const MusicView(),
              name: MusicView.routeName,
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: SettingsView.routeName,
              builder: (context, state) => const SettingsView(),
              name: SettingsView.routeName,
            )
          ],
        )
      ],
    )
  ],
);
