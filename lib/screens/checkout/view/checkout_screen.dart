import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_ecommerce_app/models/user_model.dart';
import 'package:sample_ecommerce_app/providers/cart_provider.dart';
import 'package:sample_ecommerce_app/util/calculation_functions.dart';
import 'package:sample_ecommerce_app/widgets/bottom_button.dart';
import 'package:sample_ecommerce_app/widgets/custom_popup.dart';
import 'package:sample_ecommerce_app/widgets/product_cart_card.dart';


class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  UserModel user = UserModel(name: '', phoneNumber: '', shippingAddress: '');
  bool autoValidate = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItemsList;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 251, 169, 128),
            centerTitle: false,
            iconTheme: IconThemeData(color: Colors.white.withOpacity(0.85)),
            title: Text(
              "Checkout",
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
              child: Column(
                children: [
                  Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Form(
                          key: _key,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter your name',
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.85),
                                ),
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    user.name = value;
                                    if(autoValidate){
                                      _key.currentState?.validate();
                                    }
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter your address',
                                  border: InputBorder.none, 
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.85),
                                ),
                                keyboardType: TextInputType.streetAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your address';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    user.shippingAddress = value;
                                    if(autoValidate){
                                      _key.currentState?.validate();
                                    }
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter your phone number',
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.85),
                                ),
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty || value.length != 10) {
                                    return 'Please enter a valid phone number';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    user.phoneNumber = value;
                                    if(autoValidate){
                                      _key.currentState?.validate();
                                    }
                                  });
                                },
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Cart Summary',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Total: \$${getTotalPrice(cartItems).toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 200, 
                          child: cartItems.isNotEmpty
                            ? ListView.builder(
                                itemCount: cartItems.length,
                                itemBuilder: (context, index) {
                                  var item = cartItems[index];
                                  return ProductCardCard(
                                    product: item,
                                  );
                                },
                              )
                            : const Center(child: Text("No Cart Items Available"),)
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                                        )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 8,
        left: 25,
        right: 25,
        child: AnimatedGradientButton(
          buttonText: "Place Order",
          isButtonDisabled: cartItems.isEmpty ? true : false,
          onPressed: () {
            setState(() {
              autoValidate = true;
            });
            if (_key.currentState?.validate() ?? false) {
              showCustomPopup(
                context: context,
                titleText: "Confirm",text: "Are you sure to Place Order? ",
                buttonConfirmText: "Confirm", buttonCancelText: "Cancel"
              );
            }
          },
        ),
      ),
    ]);
  }
}