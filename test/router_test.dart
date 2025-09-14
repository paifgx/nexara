import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexara/app.dart';
import 'package:nexara/core/router/app_router.dart' as app_router;
import 'package:nexara/ui/screens/today/today_screen.dart';
import 'package:nexara/ui/screens/week/week_screen.dart';
import 'package:nexara/ui/screens/plan/plan_screen.dart';
import 'package:nexara/ui/screens/texts/texts_screen.dart';
import 'package:nexara/ui/screens/settings/settings_screen.dart';

void main() {
  group('AppRouter', () {
    testWidgets('initial route is /today', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: NexaraApp(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Verify Today screen is shown
      expect(find.byType(TodayScreen), findsOneWidget);
      expect(find.text('Today'), findsWidgets);
    });

    testWidgets('can navigate to Week screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: NexaraApp(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Find and tap Week navigation button
      await tester.tap(find.text('Week'));
      await tester.pumpAndSettle();
      
      // Verify Week screen is shown
      expect(find.byType(WeekScreen), findsOneWidget);
    });

    testWidgets('can navigate to Plan screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: NexaraApp(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Find and tap Plan navigation button
      await tester.tap(find.text('Plan'));
      await tester.pumpAndSettle();
      
      // Verify Plan screen is shown
      expect(find.byType(PlanScreen), findsOneWidget);
    });

    testWidgets('can navigate to Texts screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: NexaraApp(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Find and tap Texts navigation button
      await tester.tap(find.text('Texts'));
      await tester.pumpAndSettle();
      
      // Verify Texts screen is shown
      expect(find.byType(TextsScreen), findsOneWidget);
    });

    testWidgets('can navigate to Settings screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: NexaraApp(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Find and tap Settings navigation button
      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();
      
      // Verify Settings screen is shown
      expect(find.byType(SettingsScreen), findsOneWidget);
    });

    testWidgets('can navigate back to Today from other screens', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: NexaraApp(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Navigate to Settings (find in navigation bar specifically)
      final settingsNav = find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Settings'),
      );
      await tester.tap(settingsNav);
      await tester.pumpAndSettle();
      expect(find.byType(SettingsScreen), findsOneWidget);
      
      // Navigate back to Today
      final todayNav = find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Today'),
      );
      await tester.tap(todayNav);
      await tester.pumpAndSettle();
      expect(find.byType(TodayScreen), findsOneWidget);
    });

  });

  group('NoTransitionPage', () {
    testWidgets('creates page without transition', (WidgetTester tester) async {
      const testWidget = Text('Test Widget');
      const page = app_router.NoTransitionPage(
        child: testWidget,
      );
      
      expect(page.child, equals(testWidget));
      expect(page.transitionsBuilder, isNotNull);
    });
  });
}
