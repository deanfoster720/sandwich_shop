import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

class CartItem {
  final Sandwich sandwich;
  int quantity;

  CartItem({
    required this.sandwich,
    this.quantity = 1,
  });
}

class Cart {
  final PricingRepository _pricingRepository = PricingRepository();
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  void add(Sandwich sandwich, {int quantity = 1}) {
    // If same sandwich already in cart, increase quantity
    final existingIndex = _items.indexWhere(
      (item) =>
          item.sandwich.type == sandwich.type &&
          item.sandwich.isFootlong == sandwich.isFootlong &&
          item.sandwich.breadType == sandwich.breadType,
    );

    if (existingIndex != -1) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(CartItem(sandwich: sandwich, quantity: quantity));
    }
  }

  void remove(Sandwich sandwich, {int quantity = 1}) {
    final index = _items.indexWhere(
      (item) =>
          item.sandwich.type == sandwich.type &&
          item.sandwich.isFootlong == sandwich.isFootlong &&
          item.sandwich.breadType == sandwich.breadType,
    );

    if (index == -1) return;

    _items[index].quantity -= quantity;
    if (_items[index].quantity <= 0) {
      _items.removeAt(index);
    }
  }

  void clear() {
    _items.clear();
  }

  int get totalItems {
    int total = 0;
    for (final item in _items) {
      total += item.quantity;
    }
    return total;
  }

  double get totalPrice {
    double total = 0;
    for (final item in _items) {
      total += _pricingRepository.calculatePrice(
        quantity: item.quantity,
        isFootlong: item.sandwich.isFootlong,
      );
    }
    return total;
  }

  bool get isEmpty => _items.isEmpty;
}
