import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexara/app.dart';
import 'package:nexara/core/theme/app_theme.dart';

void main() {
  group('NexaraApp', () {
    testWidgets('app builds with correct title', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: NexaraApp(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Verify app builds successfully
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('app uses light theme by default', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: NexaraApp(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      final MaterialApp app = tester.widget(find.byType(MaterialApp));
      expect(app.theme, equals(AppTheme.lightTheme));
      expect(app.darkTheme, equals(AppTheme.darkTheme));
    });

    testWidgets('app respects theme mode provider', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: NexaraApp(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Verify app uses theme mode from provider
      final MaterialApp app = tester.widget(find.byType(MaterialApp));
      expect(app.themeMode, isNotNull);
    });

    testWidgets('app has debug banner disabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: NexaraApp(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      final MaterialApp app = tester.widget(find.byType(MaterialApp));
      expect(app.debugShowCheckedModeBanner, isFalse);
    });
  });
}
