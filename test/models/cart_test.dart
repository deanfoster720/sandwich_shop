import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('Cart model', () {
    late Cart cart;
    late Sandwich footlongVeggie;
    late Sandwich sixInchVeggie;

    setUp(() {
      cart = Cart();
      footlongVeggie = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      sixInchVeggie = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: false,
        breadType: BreadType.white,
      );
    });

    test('starts empty', () {
      expect(cart.isEmpty, isTrue);
      expect(cart.totalItems, 0);
    });

    test('add increases totalItems and stores item', () {
      cart.add(footlongVeggie, quantity: 2);

      expect(cart.totalItems, 2);
      expect(cart.items.length, 1);
      expect(cart.items.first.sandwich, footlongVeggie);
      expect(cart.items.first.quantity, 2);
    });

    test('adding same sandwich increases quantity, not list length', () {
      cart.add(footlongVeggie, quantity: 1);
      cart.add(footlongVeggie, quantity: 3);

      expect(cart.items.length, 1);
      expect(cart.items.first.quantity, 4);
    });

    test('different sizes/types are treated as different items', () {
      cart.add(footlongVeggie, quantity: 1);
      cart.add(sixInchVeggie, quantity: 1);

      expect(cart.items.length, 2);
      expect(cart.totalItems, 2);
    });

    test('remove decreases quantity and removes when zero', () {
      cart.add(footlongVeggie, quantity: 2);

      cart.remove(footlongVeggie, quantity: 1);
      expect(cart.items.first.quantity, 1);
      expect(cart.totalItems, 1);

      cart.remove(footlongVeggie, quantity: 1);
      expect(cart.items.length, 0);
      expect(cart.isEmpty, isTrue);
    });
  });
}
