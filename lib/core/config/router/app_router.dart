import 'package:chillzone/features/home/presentation/screens/screens.dart';
import 'package:chillzone/features/home/presentation/screens/views/work_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _sectionANavigatorKey = GlobalKey<NavigatorState>();
final appRouter = GoRouter(
  initialLocation: SleepView.route,
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
              path: ReadView.routeName,
              builder: (context, state) => const ReadView(),
              name: ReadView.routeName,
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
              path: MeditateView.routeName,
              builder: (context, state) => const MeditateView(),
              name: MeditateView.routeName,
            ),
          ],
        ),
        StatefulShellBranch(
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
