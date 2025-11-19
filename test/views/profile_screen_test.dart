import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/profile_screen.dart';

void main() {
  group('ProfileScreen', () {
    testWidgets('shows all profile fields and allows editing',
        (WidgetTester tester) async {
      const MaterialApp app = MaterialApp(home: ProfileScreen());
      await tester.pumpWidget(app);

      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Phone number'), findsOneWidget);
      expect(find.text('Delivery address'), findsOneWidget);

      final Finder textFields = find.byType(TextFormField);
      expect(textFields, findsNWidgets(4));

      await tester.enterText(textFields.at(0), 'Taylor Toast');
      await tester.enterText(textFields.at(1), 'taylor@example.com');
      await tester.enterText(textFields.at(2), '+44 5555 000');
      await tester.enterText(textFields.at(3), '123 Rye Lane');
      await tester.pump();

      expect(find.text('Taylor Toast'), findsOneWidget);
      expect(find.text('taylor@example.com'), findsOneWidget);
      expect(find.text('+44 5555 000'), findsOneWidget);
      expect(find.text('123 Rye Lane'), findsOneWidget);
    });
  });
}
