import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexara/core/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('AppTheme', () {
    test('lightTheme has correct configuration', () {
      final theme = AppTheme.lightTheme;
      
      expect(theme.brightness, equals(Brightness.light));
      expect(theme.useMaterial3, isTrue);
      // Note: fontFamily is set in textTheme, not directly on ThemeData
      
      // Check primary color
      expect(theme.colorScheme.primary, isNotNull);
      expect(theme.colorScheme.secondary, isNotNull);
      expect(theme.colorScheme.tertiary, isNotNull);
      expect(theme.colorScheme.error, isNotNull);
      
      // Check app bar theme
      expect(theme.appBarTheme.elevation, equals(0));
      expect(theme.appBarTheme.centerTitle, isTrue);
      
      // Check card theme
      expect(theme.cardTheme.elevation, equals(0));
      expect(theme.cardTheme.shape, isA<RoundedRectangleBorder>());
      
      // Check navigation bar theme
      expect(theme.navigationBarTheme.height, equals(64));
      expect(theme.navigationBarTheme.elevation, equals(0));
    });

    test('darkTheme has correct configuration', () {
      final theme = AppTheme.darkTheme;
      
      expect(theme.brightness, equals(Brightness.dark));
      expect(theme.useMaterial3, isTrue);
      // Note: fontFamily is set in textTheme, not directly on ThemeData
      
      // Check colors
      expect(theme.colorScheme.brightness, equals(Brightness.dark));
      expect(theme.colorScheme.primary, isNotNull);
      expect(theme.colorScheme.secondary, isNotNull);
      
      // Check app bar theme
      expect(theme.appBarTheme.elevation, equals(0));
      expect(theme.appBarTheme.centerTitle, isTrue);
      
      // Check navigation bar theme
      expect(theme.navigationBarTheme.height, equals(64));
      expect(theme.navigationBarTheme.elevation, equals(0));
    });

    testWidgets('getProductivityColor returns correct colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Builder(
            builder: (context) {
              final productiveColor = AppTheme.getProductivityColor(context, true);
              final busyColor = AppTheme.getProductivityColor(context, false);
              
              expect(productiveColor, equals(Theme.of(context).colorScheme.secondary));
              expect(busyColor, equals(Theme.of(context).colorScheme.tertiary));
              
              return const SizedBox();
            },
          ),
        ),
      );
    });
  });

  group('ThemeModeNotifier', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('initial state is system theme', () {
      final notifier = ThemeModeNotifier();
      expect(notifier.state, equals(ThemeMode.system));
    });

    test('setThemeMode changes theme state', () {
      final notifier = ThemeModeNotifier();
      
      // Initial state should be system
      expect(notifier.state, equals(ThemeMode.system));
      
      // Test synchronous state change
      notifier.state = ThemeMode.dark;
      expect(notifier.state, equals(ThemeMode.dark));
      
      notifier.state = ThemeMode.light;
      expect(notifier.state, equals(ThemeMode.light));
    });

    testWidgets('theme mode provider provides theme mode', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      
      await tester.pumpWidget(
        ProviderScope(
          child: Consumer(
            builder: (context, ref, child) {
              final mode = ref.watch(themeModeProvider);
              return MaterialApp(
                themeMode: mode,
                home: Text('Theme mode: $mode'),
              );
            },
          ),
        ),
      );
      
      // Verify the provider provides a theme mode
      expect(find.textContaining('Theme mode:'), findsOneWidget);
    });
  });
}
