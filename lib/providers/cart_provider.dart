
import 'package:flutter/material.dart';
import 'package:sample_ecommerce_app/models/cart_item_model.dart';
import 'package:sample_ecommerce_app/models/product_model.dart';

class CartProvider extends ChangeNotifier{
  List<CartItemModel> cartItemsList = [];

  List<CartItemModel> get cartItems{
    return cartItemsList;
  }

  void addItemToCart(ProductModel product){
    final currentItem = cartItemsList.firstWhere( 
      (item) => item.product.productId == product.productId, 
      orElse: () => CartItemModel(product: product, quantity: 1),
    );

    if(!cartItemsList.contains(currentItem)){
      cartItemsList.add(currentItem);
    }
    notifyListeners();
  }
  void incrementItems(ProductModel product){
    final consideredItem = cartItemsList.firstWhere( (item) => item.product.productId == product.productId);
    consideredItem.incrementQuantity();
    notifyListeners();
  }

  void decrementItems(ProductModel product){
    final consideredItem = cartItemsList.firstWhere( (item) => item.product.productId == product.productId);
    consideredItem.decrementQuantity();
    notifyListeners();
  }

  void removeItemFromCart(CartItemModel product){
    cartItemsList.remove(product);
    notifyListeners();
  }

  void clearCart(){
    cartItemsList.clear();
    notifyListeners();
  }
}