import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('Sandwich model', () {
    test('name getter returns human readable name', () {
      final sandwich = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: true,
        breadType: BreadType.white,
      );

      expect(sandwich.name, 'Chicken Teriyaki');
    });

    test('image getter builds correct asset path for footlong', () {
      final sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.wheat,
      );

      expect(
        sandwich.image,
        'assets/images/veggieDelight_footlong.png',
      );
    });

    test('image getter builds correct asset path for six inch', () {
      final sandwich = Sandwich(
        type: SandwichType.meatballMarinara,
        isFootlong: false,
        breadType: BreadType.wholemeal,
      );

      expect(
        sandwich.image,
        'assets/images/meatballMarinara_six_inch.png',
      );
    });
  });
}
