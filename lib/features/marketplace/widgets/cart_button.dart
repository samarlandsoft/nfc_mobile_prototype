import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  final double size;
  final VoidCallback callback;

  const CartButton({
    Key? key,
    required this.size,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: const Icon(
          Icons.add_shopping_cart,
          color: Colors.orange,
        ),
        onPressed: callback,
      ),
    );
  }
}
