import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_ecommerce_app/models/cart_item_model.dart';
import 'package:sample_ecommerce_app/providers/cart_provider.dart';

class QuantitySetButtons extends StatefulWidget {
  final CartItemModel cartItem;
  const QuantitySetButtons({super.key, required this.cartItem});

  @override
  State<QuantitySetButtons> createState() => _QuantitySetButtonsState();
}

class _QuantitySetButtonsState extends State<QuantitySetButtons> {
  final int maxCount = 5;
  final int minCount = 1;

  @override
  Widget build(BuildContext context) {
    int currentProductCount = Provider.of<CartProvider>(context, listen: true)
        .cartItems
        .firstWhere((item) => item.product.productId == widget.cartItem.product.productId)
        .quantity;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: currentProductCount < maxCount
              ? () {
                  Provider.of<CartProvider>(context, listen: false)
                      .incrementItems(widget.cartItem.product);
                }
              : null,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: const Icon(Icons.add, color: Colors.black, size: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12.0),
          child: Text(
            currentProductCount.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        GestureDetector(
          onTap: currentProductCount > minCount
              ? () {
                  Provider.of<CartProvider>(context, listen: false)
                      .decrementItems(widget.cartItem.product);
                }
              : null,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: const Icon(Icons.remove, color: Colors.black, size: 18),
          ),
        ),
      ],
    );
  }
}