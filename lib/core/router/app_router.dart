import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexara/ui/screens/app_shell.dart';
import 'package:nexara/ui/screens/today/today_screen.dart';
import 'package:nexara/ui/screens/week/week_screen.dart';
import 'package:nexara/ui/screens/plan/plan_screen.dart';
import 'package:nexara/ui/screens/texts/texts_screen.dart';
import 'package:nexara/ui/screens/settings/settings_screen.dart';

/// Provider for the app router configuration.
final routerProvider = Provider<GoRouter>((ref) {
  return AppRouter.router;
});

/// Application routing configuration using go_router.
class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

  /// Main router configuration
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/today',
    debugLogDiagnostics: false,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return AppShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/today',
            name: 'today',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const TodayScreen(),
            ),
          ),
          GoRoute(
            path: '/week',
            name: 'week',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const WeekScreen(),
            ),
          ),
          GoRoute(
            path: '/plan',
            name: 'plan',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const PlanScreen(),
            ),
          ),
          GoRoute(
            path: '/texts',
            name: 'texts',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const TextsScreen(),
            ),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const SettingsScreen(),
            ),
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Page not found',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                state.uri.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/today'),
                child: const Text('Go to Home'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

/// Custom page with no transition animation
class NoTransitionPage<T> extends CustomTransitionPage<T> {
  const NoTransitionPage({
    required Widget child,
    super.key,
  }) : super(
          child: child,
          transitionsBuilder: _transitionsBuilder,
        );

  static Widget _transitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
