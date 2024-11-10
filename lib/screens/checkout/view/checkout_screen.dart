import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_ecommerce_app/providers/cart_provider.dart';
import 'package:sample_ecommerce_app/widgets/product_dashboard_card.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItemsList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 251, 169, 128),
        centerTitle: false,
        title: Text(
          "My Cart",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white.withOpacity(0.85)),
        ),
        // actions: [
        //   IconButton(
        //   onPressed: (){
        //     // expandSearch = true;
        //   },
        //   icon: Icon(Icons.search)
        // ),]
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 251, 169, 128),
                Color.fromARGB(255, 251, 222, 208), 
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(  
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      child: ProductDashboardCard(
                        product: cartItems[index],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      )
    );
  }
}
