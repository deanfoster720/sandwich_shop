import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart'; // gives us OrderScreen

void main() {
  testWidgets('Add to Cart is disabled when quantity is 0',
      (WidgetTester tester) async {
    // Build the widget inside a MaterialApp
    await tester.pumpWidget(
      const MaterialApp(
        home: OrderScreen(maxQuantity: 5),
      ),
    );

    // Find the Add to Cart button (the ElevatedButton built by StyledButton)
    final Finder addButtonFinder =
        find.widgetWithText(ElevatedButton, 'Add to Cart');

    // Initially quantity is 1, so button should be enabled
    ElevatedButton addButton = tester.widget<ElevatedButton>(addButtonFinder);
    expect(addButton.onPressed, isNotNull);

    // Tap the "-" icon to reduce quantity to 0
    final Finder decreaseButtonFinder = find.byIcon(Icons.remove);
    await tester.ensureVisible(decreaseButtonFinder);
    await tester.tap(decreaseButtonFinder);
    await tester.pumpAndSettle();

    // Now button should be disabled
    addButton = tester.widget<ElevatedButton>(addButtonFinder);
    expect(addButton.onPressed, isNull);
  });

  testWidgets('Quantity cannot exceed maxQuantity',
      (WidgetTester tester) async {
    const int maxQuantity = 5;

    await tester.pumpWidget(
      const MaterialApp(
        home: OrderScreen(maxQuantity: maxQuantity),
      ),
    );

    final Finder increaseButtonFinder = find.byIcon(Icons.add);

    // Ensure the increase button is visible before tapping
    await tester.ensureVisible(increaseButtonFinder);

    // Tap "+" more times than maxQuantity
    for (int i = 0; i < 10; i++) {
      await tester.tap(increaseButtonFinder);
    }
    await tester.pumpAndSettle();

    // Check that the displayed quantity text is maxQuantity, not higher
    expect(find.text('$maxQuantity'), findsOneWidget);
  });

  testWidgets('Displays confirmation message when sandwich is added',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: OrderScreen(maxQuantity: 5),
      ),
    );

    const String expectedMessage =
        'Added 1 footlong Veggie Delight sandwich(es) on white bread to cart';

    expect(find.text(expectedMessage), findsNothing);

    final Finder addButtonFinder =
        find.widgetWithText(ElevatedButton, 'Add to Cart');
    await tester.ensureVisible(addButtonFinder);
    await tester.tap(addButtonFinder);
    await tester.pumpAndSettle();

    expect(find.text(expectedMessage), findsOneWidget);
  });

  testWidgets('Cart summary updates item count and total after additions',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: OrderScreen(maxQuantity: 5),
      ),
    );

    // Initially the cart is empty, so the placeholder text should be visible.
    expect(
      find.text('Your cart is currently empty.'),
      findsOneWidget,
    );

    final Finder addButtonFinder =
        find.widgetWithText(ElevatedButton, 'Add to Cart');

    // Ensure the add button is visible and add the default sandwich once
    await tester.ensureVisible(addButtonFinder);
    await tester.tap(addButtonFinder);
    await tester.pumpAndSettle();
    expect(
      find.text('Cart: 1 sandwich · Total: £11.00'),
      findsOneWidget,
    );

    // Add the same sandwich again, verifying the count and total double.
    await tester.ensureVisible(addButtonFinder);
    await tester.tap(addButtonFinder);
    await tester.pumpAndSettle();
    expect(
      find.text('Cart: 2 sandwiches · Total: £22.00'),
      findsOneWidget,
    );
  });
}
