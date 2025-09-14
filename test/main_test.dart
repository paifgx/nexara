import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexara/main.dart';
import 'package:nexara/app.dart';

void main() {
  group('Main app initialization', () {
    testWidgets('main function initializes app correctly', (WidgetTester tester) async {
      // Test that the main function properly initializes the app
      WidgetsFlutterBinding.ensureInitialized();
      
      await tester.pumpWidget(
        const ProviderScope(
          child: NexaraApp(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Verify the app is running
      expect(find.byType(NexaraApp), findsOneWidget);
      expect(find.byType(ProviderScope), findsOneWidget);
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('app has correct provider scope', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: NexaraApp(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Verify provider scope exists and contains the app
      final providerScope = find.byType(ProviderScope);
      expect(providerScope, findsOneWidget);
      
      final nexaraApp = find.descendant(
        of: providerScope,
        matching: find.byType(NexaraApp),
      );
      expect(nexaraApp, findsOneWidget);
    });
  });

  group('App lifecycle', () {
    testWidgets('app handles orientation changes', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: NexaraApp(),
        ),
      );
      
      await tester.pumpAndSettle();
      
      // Initial orientation
      expect(find.byType(NexaraApp), findsOneWidget);
      
      // Change to landscape
      tester.view.physicalSize = const Size(800, 400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pump();
      
      // App should still be there
      expect(find.byType(NexaraApp), findsOneWidget);
      
      // Change back to portrait
      tester.view.physicalSize = const Size(400, 800);
      await tester.pump();
      
      expect(find.byType(NexaraApp), findsOneWidget);
      
      // Reset to default
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    testWidgets('app handles different screen sizes', (WidgetTester tester) async {
      // Test with standard mobile screen size
      await tester.pumpWidget(
        const ProviderScope(
          child: NexaraApp(),
        ),
      );
      
      await tester.pumpAndSettle();
      expect(find.byType(NexaraApp), findsOneWidget);
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
