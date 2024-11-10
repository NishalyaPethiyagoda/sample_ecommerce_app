import 'package:flutter/material.dart';
import 'package:sample_ecommerce_app/screens/checkout/view/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CheckoutScreen(),
            ));
          },
          child: Text("Proceed to Checkout"),
        ),
      ),
    );
  }
}