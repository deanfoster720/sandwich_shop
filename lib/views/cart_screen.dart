import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/app_styles.dart';
import 'package:sandwich_shop/views/order_screen.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

class CartScreen extends StatefulWidget {
  final Cart cart;

  const CartScreen({super.key, required this.cart});

  @override
  State<CartScreen> createState() {
    return _CartScreenState();
  }
}

class _CartScreenState extends State<CartScreen> {
  void _goBack() {
    Navigator.pop(context);
  }

  String _getSizeText(bool isFootlong) {
    if (isFootlong) {
      return 'Footlong';
    } else {
      return 'Six-inch';
    }
  }

  double _getItemPrice(Sandwich sandwich, int quantity) {
    final PricingRepository pricingRepository = PricingRepository();
    return pricingRepository.calculatePrice(
      quantity: quantity,
      isFootlong: sandwich.isFootlong,
    );
  }

  void _increaseQuantity(Sandwich sandwich) {
    setState(() {
      widget.cart.add(sandwich, quantity: 1);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Increased ${sandwich.name} quantity'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _decreaseQuantity(Sandwich sandwich) {
    setState(() {
      widget.cart.remove(sandwich, quantity: 1);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Decreased ${sandwich.name} quantity'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _removeItem(Sandwich sandwich) {
    setState(() {
      widget.cart.remove(sandwich, quantity: widget.cart.getQuantity(sandwich));
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Removed ${sandwich.name} from cart'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 100,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
        title: const Text(
          'Cart View',
          style: heading1,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              if (widget.cart.items.isEmpty)
                Column(
                  children: const [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Your cart is empty',
                      style: heading2,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Add sandwiches from the order screen to get started.',
                      style: normalText,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                  ],
                )
              else
                for (MapEntry<Sandwich, int> entry in widget.cart.items.entries)
                  Column(
                    children: [
                      Text(entry.key.name, style: heading2),
                      Text(
                        '${_getSizeText(entry.key.isFootlong)} on ${entry.key.breadType.name} bread',
                        style: normalText,
                      ),
                      Text(
                        'Qty: ${entry.value} - £${_getItemPrice(entry.key, entry.value).toStringAsFixed(2)}',
                        style: normalText,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => _decreaseQuantity(entry.key),
                            icon: const Icon(Icons.remove),
                          ),
                          Text('${entry.value}', style: heading2),
                          IconButton(
                            onPressed: () => _increaseQuantity(entry.key),
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => _removeItem(entry.key),
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
              Text(
                'Total: £${widget.cart.totalPrice.toStringAsFixed(2)}',
                style: heading2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              StyledButton(
                onPressed: _goBack,
                icon: Icons.arrow_back,
                label: 'Back to Order',
                backgroundColor: Colors.grey,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
