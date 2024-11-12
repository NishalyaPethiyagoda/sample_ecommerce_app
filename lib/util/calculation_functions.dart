import 'package:sample_ecommerce_app/models/cart_item_model.dart';

double getTotalPrice (List<CartItemModel> cartItems){
  double totalPrice = 0.0;

  for(var item in cartItems){
    totalPrice += item.product.price * item.quantity;
  }
  return totalPrice;
}