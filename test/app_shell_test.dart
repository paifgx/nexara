import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexara/app.dart';
import 'package:nexara/ui/screens/app_shell.dart';

void main() {
  group('AppShell', () {
    testWidgets('displays NavigationBar with all destinations', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: NexaraApp(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Verify NavigationBar exists
      expect(find.byType(NavigationBar), findsOneWidget);
      
      // Verify all navigation destinations (might find multiple 'Today' due to app bar and nav)
      expect(find.text('Today'), findsWidgets);
      expect(find.text('Week'), findsOneWidget);
      expect(find.text('Plan'), findsOneWidget);
      expect(find.text('Texts'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('shows correct icons for navigation destinations', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: NexaraApp(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Check for navigation icons (selected or unselected versions)
      expect(
        find.byIcon(Icons.today_outlined).evaluate().isNotEmpty ||
        find.byIcon(Icons.today).evaluate().isNotEmpty,
        isTrue,
      );
      expect(
        find.byIcon(Icons.calendar_view_week_outlined).evaluate().isNotEmpty ||
        find.byIcon(Icons.calendar_view_week).evaluate().isNotEmpty,
        isTrue,
      );
      expect(
        find.byIcon(Icons.schedule_outlined).evaluate().isNotEmpty ||
        find.byIcon(Icons.schedule).evaluate().isNotEmpty,
        isTrue,
      );
      expect(
        find.byIcon(Icons.text_fields_outlined).evaluate().isNotEmpty ||
        find.byIcon(Icons.text_fields).evaluate().isNotEmpty,
        isTrue,
      );
      expect(
        find.byIcon(Icons.settings_outlined).evaluate().isNotEmpty ||
        find.byIcon(Icons.settings).evaluate().isNotEmpty,
        isTrue,
      );
    });

    testWidgets('Today is selected by default', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: NexaraApp(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Today should have the selected icon
      expect(find.byIcon(Icons.today), findsOneWidget);
      
      // Others should have unselected icons
      expect(find.byIcon(Icons.calendar_view_week_outlined), findsOneWidget);
      expect(find.byIcon(Icons.schedule_outlined), findsOneWidget);
      expect(find.byIcon(Icons.text_fields_outlined), findsOneWidget);
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
    });

    testWidgets('navigation updates selected index correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: NexaraApp(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Navigate to Week
      await tester.tap(find.text('Week'));
      await tester.pumpAndSettle();
      
      // Week should now be selected
      expect(find.byIcon(Icons.calendar_view_week), findsOneWidget);
      expect(find.byIcon(Icons.today_outlined), findsOneWidget);
      
      // Navigate to Settings
      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();
      
      // Settings should now be selected
      expect(find.byIcon(Icons.settings), findsOneWidget);
      expect(find.byIcon(Icons.calendar_view_week_outlined), findsOneWidget);
    });

    testWidgets('NavigationBar has proper tooltips', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: NexaraApp(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Find NavigationDestination widgets by their tooltips
      final todayDestination = find.byWidgetPredicate(
        (widget) => widget is NavigationDestination && widget.tooltip == 'Today\'s productivity',
      );
      final weekDestination = find.byWidgetPredicate(
        (widget) => widget is NavigationDestination && widget.tooltip == 'Weekly overview',
      );
      final planDestination = find.byWidgetPredicate(
        (widget) => widget is NavigationDestination && widget.tooltip == 'Schedule settings',
      );
      final textsDestination = find.byWidgetPredicate(
        (widget) => widget is NavigationDestination && widget.tooltip == 'Reminder texts',
      );
      final settingsDestination = find.byWidgetPredicate(
        (widget) => widget is NavigationDestination && widget.tooltip == 'App settings',
      );
      
      expect(todayDestination, findsOneWidget);
      expect(weekDestination, findsOneWidget);
      expect(planDestination, findsOneWidget);
      expect(textsDestination, findsOneWidget);
      expect(settingsDestination, findsOneWidget);
    });
  });
}
