
import 'package:flutter/material.dart';
import 'package:sample_ecommerce_app/models/product_model.dart';

class CartProvider extends ChangeNotifier{
  final List<ProductModel> cartItemsList = [];

  List<ProductModel> get cartItems{
    return cartItemsList;
  }

  void addItemToCart(ProductModel product){
    cartItemsList.add(product);
    notifyListeners();
  }

  void removeItemFromCart(ProductModel product){
    cartItemsList.remove(product);
    notifyListeners();
  }

  void clearCart(){
    cartItemsList.clear();
    notifyListeners();
  }
}