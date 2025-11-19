import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/about_screen.dart';
import 'package:sandwich_shop/views/profile_screen.dart';
import 'package:sandwich_shop/views/order_screen.dart';

void main() {
  group('Navigation Tests', () {
    testWidgets('Drawer navigation works correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (_) => const OrderScreen(maxQuantity: 5),
            '/about': (_) => const AboutScreen(),
            '/profile': (_) => const ProfileScreen(),
          },
        ),
      );

      // Open the drawer
      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();

      // Verify Drawer content
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);

      // Tap on Profile navigation option
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('NavigationRail appears on wider screens',
        (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (_) => const OrderScreen(maxQuantity: 5),
            '/about': (_) => const AboutScreen(),
            '/profile': (_) => const ProfileScreen(),
          },
        ),
      );

      // Verify NavigationRail is present
      expect(find.byType(NavigationRail), findsOneWidget);
    });
  });
}
