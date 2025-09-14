// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nexara/app.dart';

void main() {
  testWidgets('App initializes and shows Today screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: NexaraApp(),
      ),
    );
    
    // Pump and settle to let animations complete
    await tester.pumpAndSettle();

    // Verify that the app shows the Today screen (multiple "Today" texts are expected)
    expect(find.text('Today'), findsWidgets);
    
    // Verify bottom navigation exists
    expect(find.byType(NavigationBar), findsOneWidget);
    
    // Verify we can see some text from the Today screen
    expect(find.text('Productive'), findsWidgets);
  });
}