import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sandwich Shop App',
      home: OrderScreen(maxQuantity: 5),
    );
  }
}

class OrderScreen extends StatefulWidget {
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 10});

  @override
  State<OrderScreen> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrderScreen> {
  int _quantity = 0;
  String _size = "Footlong";

  VoidCallback? get _increaseQuantity =>
      _quantity < widget.maxQuantity ? () => setState(() => _quantity++) : null;

  VoidCallback? get _decreaseQuantity =>
      _quantity > 0 ? () => setState(() => _quantity--) : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandwich Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: _size,
              items: const [
                DropdownMenuItem(value: 'Footlong', child: Text('Footlong')),
                DropdownMenuItem(value: 'Six-inch', child: Text('Six-inch')),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _size = value);
              },
            ),
            OrderItemDisplay(
              _quantity,
              _size,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StyledButton(
                  onPressed: _increaseQuantity ?? () {},
                  text: 'Add',
                  backgroundColor: Colors.red,
                ),
                StyledButton(
                  onPressed: _decreaseQuantity ?? () {},
                  text: 'Remove',
                  backgroundColor: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItemDisplay extends StatelessWidget {
  final int quantity;
  final String itemType;

  const OrderItemDisplay(this.quantity, this.itemType, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text('$quantity $itemType sandwich(es): ${'🥪' * quantity}');
  }
}

class StyledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color backgroundColor;

  const StyledButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
      ),
      child: Text(text),
    );
  }
}
