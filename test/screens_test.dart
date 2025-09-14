import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexara/app.dart';
import 'package:nexara/ui/screens/today/today_screen.dart';
import 'package:nexara/ui/screens/week/week_screen.dart';
import 'package:nexara/ui/screens/plan/plan_screen.dart';
import 'package:nexara/ui/screens/texts/texts_screen.dart';
import 'package:nexara/ui/screens/settings/settings_screen.dart';

void main() {
  group('TodayScreen', () {
    testWidgets('displays all main components', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TodayScreen(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Check app bar
      expect(find.text('Today'), findsOneWidget);
      expect(find.byIcon(Icons.add_circle_outline), findsOneWidget);
      
      // Check daily summary card
      expect(find.text('67%'), findsOneWidget);
      expect(find.text('Productive'), findsWidgets);
      
      // Check stat chips
      expect(find.text('2/3'), findsOneWidget);
      expect(find.text('5 day streak'), findsOneWidget);
      
      // Check check-in section
      expect(find.text('Today\'s Check-ins'), findsOneWidget);
      
      // Check check-in items
      expect(find.text('09:30 AM'), findsOneWidget);
      expect(find.text('01:15 PM'), findsOneWidget);
      expect(find.text('04:45 PM'), findsOneWidget);
      expect(find.text('Just Busy'), findsOneWidget);
      expect(find.text('Pending'), findsOneWidget);
    });

    testWidgets('check-in items display correct icons', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TodayScreen(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Check for trending icons
      expect(find.byIcon(Icons.trending_up), findsOneWidget); // Productive
      expect(find.byIcon(Icons.trending_flat), findsOneWidget); // Just Busy
      expect(find.byIcon(Icons.schedule), findsOneWidget); // Pending
      
      // Check for stat icons
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.byIcon(Icons.local_fire_department), findsOneWidget);
    });

    testWidgets('manual check-in button has correct tooltip', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TodayScreen(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      final button = find.byWidgetPredicate(
        (widget) => widget is IconButton && widget.tooltip == 'Manual check-in',
      );
      
      expect(button, findsOneWidget);
    });
  });

  group('WeekScreen', () {
    testWidgets('displays week screen content', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: WeekScreen(),
          ),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Verify the screen renders
      expect(find.byType(WeekScreen), findsOneWidget);
      
      // Check app bar
      expect(find.text('Week Overview'), findsOneWidget);
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
      
      // Check week summary
      expect(find.text('This Week'), findsOneWidget);
      expect(find.text('72%'), findsOneWidget);
      expect(find.text('15/21'), findsOneWidget);
      expect(find.text('Streak'), findsOneWidget);
      
      // Check heatmap section
      expect(find.text('Productivity Heatmap'), findsOneWidget);
      expect(find.text('Morning'), findsOneWidget);
      expect(find.text('Afternoon'), findsOneWidget);
      expect(find.text('Evening'), findsOneWidget);
      
      // Check days of week
      expect(find.text('Mon'), findsOneWidget);
      expect(find.text('Tue'), findsOneWidget);
      expect(find.text('Wed'), findsOneWidget);
      expect(find.text('Thu'), findsOneWidget);
      expect(find.text('Fri'), findsOneWidget);
      expect(find.text('Sat'), findsOneWidget);
      expect(find.text('Sun'), findsOneWidget);
      
      // Check achievements section
      expect(find.text('Achievements'), findsOneWidget);
      expect(find.text('5 Day Streak'), findsOneWidget);
      expect(find.text('First Week'), findsOneWidget);
      expect(find.text('80% Productive'), findsOneWidget);
    });
    
    testWidgets('calendar button has correct tooltip', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: WeekScreen(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      final button = find.byWidgetPredicate(
        (widget) => widget is IconButton && widget.tooltip == 'Select week',
      );
      
      expect(button, findsOneWidget);
    });
  });

  group('PlanScreen', () {
    testWidgets('displays plan screen content', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: PlanScreen(),
          ),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Verify the screen renders
      expect(find.byType(PlanScreen), findsOneWidget);
    });
  });

  group('TextsScreen', () {
    testWidgets('displays texts screen content', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: TextsScreen(),
          ),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Verify the screen renders
      expect(find.byType(TextsScreen), findsOneWidget);
    });
  });

  group('SettingsScreen', () {
    testWidgets('displays settings screen content', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: SettingsScreen(),
          ),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Verify the screen renders
      expect(find.byType(SettingsScreen), findsOneWidget);
    });
  });

  group('Screen Navigation Integration', () {
    testWidgets('can navigate between all screens', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: NexaraApp(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Start at Today
      expect(find.byType(TodayScreen), findsOneWidget);
      
      // Navigate to Week
      await tester.tap(find.text('Week'));
      await tester.pumpAndSettle();
      expect(find.byType(WeekScreen), findsOneWidget);
      
      // Navigate to Plan
      await tester.tap(find.text('Plan'));
      await tester.pumpAndSettle();
      expect(find.byType(PlanScreen), findsOneWidget);
      
      // Navigate to Texts
      await tester.tap(find.text('Texts'));
      await tester.pumpAndSettle();
      expect(find.byType(TextsScreen), findsOneWidget);
      
      // Navigate to Settings
      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();
      expect(find.byType(SettingsScreen), findsOneWidget);
      
      // Navigate back to Today
      await tester.tap(find.text('Today'));
      await tester.pumpAndSettle();
      expect(find.byType(TodayScreen), findsOneWidget);
    });
  });
}
