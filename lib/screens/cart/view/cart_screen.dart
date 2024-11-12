import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_ecommerce_app/providers/cart_provider.dart';
import 'package:sample_ecommerce_app/screens/checkout/view/checkout_screen.dart';
import 'package:sample_ecommerce_app/util/calculation_functions.dart';
import 'package:sample_ecommerce_app/widgets/bottom_button.dart';
import 'package:sample_ecommerce_app/widgets/product_cart_card.dart';
import 'package:sample_ecommerce_app/widgets/text_gradient_container.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
            padding: const EdgeInsets.all(8.0 ),
            child: Stack(
              children: [ 
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 60.0),
                  child: cartItems.isNotEmpty ? ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: ProductCardCard(
                              product: cartItems[index],
                            ),
                          ),
                        ],
                      );
                    },
                  ): Center(child: Text("No Items Added to Cart", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.85)),),),
                ),
                
                Positioned(
                  bottom: 60,
                  left: 60,
                  right: 60,
                  child: Center(
                    child: TextGradientContainer(
                      text: "Total Amount: \$ ${getTotalPrice(cartItems).toString()}",
                    ),
                  ),
                ),      
                Positioned(
                  bottom: 2,
                  left: 25,
                  right: 25,
                  child: AnimatedGradientButton(
                    buttonText: "Checkout",
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CheckoutScreen()
                      ));
                    },
                    isButtonDisabled: cartItems.isEmpty ? true : false
                  ),
                ),
              ]
            ),
          ),
        ),
      )
    );
  }
}