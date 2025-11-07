import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  group('PricingRepository', () {
    test('calculates total for six-inch sandwiches', () {
      const pricingRepository = PricingRepository();

      final total = pricingRepository.calculateTotalPrice(
        quantity: 2,
        isFootlong: false,
      );

      expect(total, 14.0); // 2 * £7
    });

    test('calculates total for footlong sandwiches', () {
      const pricingRepository = PricingRepository();

      final total = pricingRepository.calculateTotalPrice(
        quantity: 3,
        isFootlong: true,
      );

      expect(total, 33.0); // 3 * £11
    });

    test('returns 0.0 when quantity is 0', () {
      const pricingRepository = PricingRepository();

      final total = pricingRepository.calculateTotalPrice(
        quantity: 0,
        isFootlong: true,
      );

      expect(total, 0.0);
    });
  });
}
